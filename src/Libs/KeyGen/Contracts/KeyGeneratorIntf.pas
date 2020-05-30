(*!------------------------------------------------------------
 * Fano CLI Application (https://fanoframework.github.io)
 *
 * @link      https://github.com/fanoframework/fano-cli
 * @copyright Copyright (c) 2018 - 2020 Zamrony P. Juhara
 * @license   https://github.com/fanoframework/fano-cli/blob/master/LICENSE (MIT)
 *------------------------------------------------------------- *)
unit KeyGeneratorIntf;

interface

{$MODE OBJFPC}
{$H+}

type

    (*!--------------------------------------
     * Interface for class that having capability
     * to generate random key
     *
     * @author Zamrony P. Juhara <zamronypj@yahoo.com>
     *---------------------------------------*)
    IKeyGenerator = interface
        ['{CDF2A4BD-0161-4390-AC21-758399D89698}']

        function generate(const len : integer; const prefix : string = '') : string;
    end;

implementation

end.
