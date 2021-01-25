with Ada.Text_IO;   use Ada.Text_IO;
with Ada.Real_Time; use Ada.Real_Time;

with Sparklies.Units; use Sparklies.Units;

procedure Sparklies.Main is

   ns : constant Units.Time := (s * 1.0E-9);

   --  NOTE: Nanoseconds is chosen here because on my system
   --  Ada.Real_Time.Time_Unit is equal to 1.0E-9, which is one nanosecond.
   function To_Time_Unit (TS : in Time_Span) return Units.Time is
      (Sparklies.Units.Mks_Type (TS / Nanoseconds (1)) * ns);

   L     :          Units.Length := 0.0 * m;
   Speed : constant Units.Speed  := 2.0 * m / s;
   DT    :          Units.Time;

   Initial  : constant Ada.Real_Time.Time := Clock;
   Previous :          Ada.Real_Time.Time := Initial;
   Final    : constant Ada.Real_Time.Time := Initial + Seconds (5);
begin
   loop
      exit when Previous > Final;

      DT       := To_Time_Unit (Clock - Previous);
      Previous := Clock;
      L        := L + (Speed * DT);

      Put ("L = " & L'Img & " metres");
      New_Line;

      delay 0.001;
   end loop;
end Sparklies.Main;
