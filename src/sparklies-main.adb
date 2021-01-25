with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

with Sparklies.Units; use Sparklies.Units;

procedure Sparklies.Main is

   function To_Time_Unit (TS : in Time_Span) return Units.Time is
      (Sparklies.Units.Mks_Type (TS / Nanoseconds (1)) * s * 1.0e-9);

   L     :          Units.Length := 0.0 * m;
   Speed : constant Units.Speed  := 2.0 * m / s;

   Initial : constant Ada.Real_Time.Time := Clock;
   Now     :          Ada.Real_Time.Time := Initial;
   DT      :          Units.Time;
   Final   : constant Ada.Real_Time.Time := Initial + Seconds (5);
begin
   loop
      exit when Now > Final;

      DT  := To_Time_Unit (Clock - Now);
      Now := Clock;
      L   := L + (Speed * DT);

      Put ("L = " & L'Img & " metres");
      New_Line;

      delay 0.001;
   end loop;
end Sparklies.Main;
