package body Sparklies.Renderer is

   procedure Create_Renderable_From_Obj
      (Ret       :    out Renderable;
       File_Path : in     String)
   is
      --  Vertex_Count : constant Size := Obj.Count_Vertices (File_Path);
      --  Model        : Model_Data (Vertex_Count);
      --  VAO          : Vertex_Array_Object;
   begin
      null;
      --  Obj.Parse     (Ret => Model, File_Path => File_Path);
      --  To_VAO        (Ret => VAO,   Model     => Model);
      --  To_Renderable (Ret => Ret,   VAO       => VAO);
   end Create_Renderable_From_Obj;

end Sparklies.Renderer;