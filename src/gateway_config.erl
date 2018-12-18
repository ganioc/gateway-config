-module(gateway_config).

-export([firmware_version/0, serial_number/0, gps_info/0, gps_sat_info/0]).

firmware_version() ->
    case file:read_file("/etc/lsb_release") of
        {error,_}  ->
            Result = string:trim(os:cmd("lsb_release -rs")),
            case lists:suffix("not found", Result) of
                true ->
                    lager:warning("No firmware version found"),
                    "unknown";
                false ->
                    Result
            end;
        {ok, File} ->
            Lines = string:split(binary_to_list(File), "\n", all),
            Props = [{K, V} || [K, V] <-  [string:split(E, "=") || E <- Lines]],
            case lists:keyfind("DISTRIB_RELEASE", 1, Props) of
                false -> "unknown";
                {_, Version} -> Version
            end
    end.

serial_number() ->
    {ok, S} = inet:getifaddrs(),
    case lists:filter(fun({K, _}) ->
                              lists:prefix("eth", K) orelse
                                  lists:prefix("en", K)
                      end, S) of
        [] ->
            lager:warning("No ethernet interface found"),
            "unknown";
        [{_, Props} | _] ->
            case lists:keyfind(hwaddr, 1, Props) of
                false -> "unknown";
                {_,  Addr} ->
                    string:join([io_lib:format("~2.16.0B", [X]) || X <- Addr], ":")
            end
    end.

gps_info() ->
    gateway_config_worker:gps_info().

gps_sat_info() ->
    gateway_config_worker:gps_sat_info().