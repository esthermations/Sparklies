--  with GL.Objects.Vertex_Arrays; use GL.Objects.Vertex_Arrays;
with GL.Types;                 use GL.Types.Singles;

package Sparklies.Renderer is

   type Renderable is new Positive;

   procedure Create_Renderable_From_Obj
      (Ret       :    out Renderable;
       File_Path : in     String);

   type Model_Data (Vertex_Count : GL.Types.Size) is
      record
         Positions : Vector3_Array (0 .. Vertex_Count);
         Normals   : Vector3_Array (0 .. Vertex_Count);
      end record;

private

   Next_Renderable : Renderable := Renderable'First;

   --  procedure To_VAO
   --     (Ret   :    out Vertex_Array_Object;
   --      Model : in     Model_Data);

   --  procedure Assign_Renderable_Handle
   --     (Ret :    out Renderable;
   --      VAO : in     Vertex_Array_Object);

end Sparklies.Renderer;