Library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
USE ieee.numeric_std.ALL;


entity AirDrums is
generic(ClockFrequency: integer:=50e6);


port(MS1,MS2,MS3, ssi,switch,clk,MetroButton: in std_logic;
		MSO1,MSO2,MSO3, sso: out std_logic;
		 LED1, LED2, LED3,LED4: out std_Logic;
		 counter: out integer Range 0 to 15 :=0);
		 
end AirDrums;

Architecture arc of AirDrums is
signal s,fire: integer:= 0;
signal flag,fireflag: std_logic:='0';
signal oldc: integer; 
--counter<='0';
--s<=0;
Begin


Process(MS1,MS2,MS3,ssi,clk,switch,MetroButton)
begin
LED1<='1';
LED2<='1';
LED3<='1';
LED4<='1';
mso1<='0';
mso2<='0';
mso3<='0';
sso<='0';
		if MS1 = '1'
				then MSO1<='1';
						LED1<='0';
		end if;
		
		if MS2 = '1'
				then MSO2<='1';
					LED2<='0';

		end if;
		
		if MS3 = '1'
				then MSO3<='1';

		end if;
		
		
		if MetroButton='0' then
				sso<='1';
				LED3<='0';

				
		end if;
		
		
		if falling_edge(ssi) and switch='1'
            then 
                if flag='1' and s>5000000
                then fireflag<='1';
                else
                    fire<=fire+1;
                    flag<='1';
                    end if;
            end if;

            if rising_edge(clk) and flag='1' and switch='1' and fireflag='0' then
                s<=s+1;
                oldc<=s;
            end if; 

            if switch='0' then
                s<=0;
                fireflag<='0';
                fire<=0;
                flag<='0';

                if (integer(oldc/5000000))>=15 then
                    counter<=15;                            
                    else
                counter<=integer(oldc/5000000);
                end if;

			end if;
			
end process;
end arc;