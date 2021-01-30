with GL;               use GL;
with Ada.Text_IO;      use Ada.Text_IO;
with GNATCOLL.Strings; use GNATCOLL.Strings;

package body Sparklies.Renderer.Obj is

   procedure Count_Vertices
      (Count         :    out GL.Types.Size;
       Obj_File_Path : in     String)
   is
      Obj_File   : File_Type;
      Line       : XString;
      Sum        : GL.Types.Size := 0;
   begin
      Open (File => Obj_File,
            Name => Obj_File_Path,
            Mode => In_File);

      loop
         exit when End_Of_File (Obj_File);

         Line.Set (Get_Line (Obj_File));

         if Line.Starts_With ("f") then
            --  ASSUMPTION: There are as many spaces in a face string as there
            --  are vertices.
            Sum := @ + Size (Line.Count (' '));
         end if;
      end loop;
      Count := Sum;

      Close (Obj_File);

   end Count_Vertices;

   procedure Parse
      (Ret           :    out Model_Data;
       Vertex_Count  : in     Size;
       Obj_File_Path : in     String)
   is
      Obj_File   : File_Type;
      Line       : XString;
      Split_Line : XString_Array (1 .. 10);
      Split_Last : Natural;

      type Obj_Token is (Unrecognised, V, VN, F);
      --  There are more, but we don't care about those!

      function To_Token (S : in XString) return Obj_Token;

      function To_Token (S : in XString) return Obj_Token is
      begin
         return Obj_Token'Value (S.To_String);
      exception
         when others => return Unrecognised;
      end To_Token;

      Token : Obj_Token;

      Unique_Positions : Vector3_Array (0 .. Vertex_Count);
      Unique_Normals   : Vector3_Array (0 .. Vertex_Count);

      UP_Idx : Size := 0;
      UN_Idx : Size := 0;

      Model : Model_Data (Vertex_Count);
      Model_Idx : Size := 0;

   begin
      Open (File => Obj_File,
            Name => Obj_File_Path,
            Mode => In_File);

      loop
         exit when End_Of_File (Obj_File);

         Line.Set (Get_Line (Obj_File));

         --   .2.....8......15....
         --  'f 1/2/3 4/5/6/ 7/8/9'
         --  [1,2], [3,8], [9,15], [16,Line'Last]

         Line.Split (Sep        => " ",
                     Omit_Empty => True,
                     Into       => Split_Line,
                     Last       => Split_Last);

         pragma Assert (Split_Line'Length >= 1);
         Token := To_Token (Split_Line (1));

         case Token is
            when V =>
               Unique_Positions (UP_Idx) :=
                  Vector3'(X => Single'Value (Split_Line (2).To_String),
                           Y => Single'Value (Split_Line (3).To_String),
                           Z => Single'Value (Split_Line (4).To_String));
               UP_Idx := @ + 1;
            when VN =>
               Unique_Normals (UN_Idx) :=
                  Vector3'(X => Single'Value (Split_Line (2).To_String),
                           Y => Single'Value (Split_Line (3).To_String),
                           Z => Single'Value (Split_Line (4).To_String));
               UN_Idx := @ + 1;
            when F =>
               for Substring of Split_Line (2 .. Split_Last) loop
                  --  For each '1/2/3' style token
                  declare
                     Indices : XString_Array (1 .. 3);
                     Last    : Natural;
                  begin
                     Substring.Split (Sep        => "/",
                                      Omit_Empty => False,
                                      Into       => Indices,
                                      Last       => Last);

                     Model.Positions (Model_Idx) :=
                        Unique_Positions
                           (Size'Value (Indices (1).To_String) - 1);
                     Model.Normals (Model_Idx) :=
                        Unique_Normals
                           (Size'Value (Indices (3).To_String) - 1);

                     Model_Idx := @ + 1;
                  end;
               end loop;
            when Unrecognised => null;
         end case;
      end loop;

      Put_Line ("Model_Idx = " & Model_Idx'Img);

      Close (Obj_File);
      Ret := Model;
   end Parse;

end Sparklies.Renderer.Obj;