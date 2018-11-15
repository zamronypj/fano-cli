(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)

unit ListIntf;

interface

{$MODE OBJFPC}
{$H+}

type
    {------------------------------------------------
     interface for any class having capability store hash list
     @author Zamrony P. Juhara <zamronypj@yahoo.com>
    -----------------------------------------------}
    IList = interface
        ['{0F439A0A-7156-4DC6-9B8C-96F4439810E7}']
        function count() : integer;
        function get(const indx : integer) : pointer;
        procedure delete(const indx : integer);
        function add(const key : shortstring; const routeData : pointer) : integer;
        function find(const key : shortstring) : pointer;
        function keyOfIndex(const indx : integer) : shortstring;
    end;

implementation
end.
