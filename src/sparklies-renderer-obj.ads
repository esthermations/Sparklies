with Ada.Directories;
with GL.Types;           use GL.Types;
with Sparklies.Renderer; use Sparklies.Renderer;

package Sparklies.Renderer.Obj is

   procedure Count_Vertices
      (Count         :    out GL.Types.Size;
       Obj_File_Path : in     String)
   with
      Post => (if not Ada.Directories.Exists (Obj_File_Path) then Count = 0);

   procedure Parse
      (Ret           :    out Model_Data;
       Vertex_Count  : in     Size;
       Obj_File_Path : in     String)
   with
      Pre  => Vertex_Count > 0,
      Post => Ret.Vertex_Count = Vertex_Count;

end Sparklies.Renderer.Obj;