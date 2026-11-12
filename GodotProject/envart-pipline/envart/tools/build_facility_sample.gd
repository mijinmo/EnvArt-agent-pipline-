extends "res://envart/tools/build_direction_base.gd"
func luminaire(pos: Vector3,yaw:=0.0) -> void:
	var n:=s("Prop_Light_Wide",pos,Vector3.ONE,yaw)
	point_light(pos+Vector3(0,-0.15,0),Color("a2e5ff"),0.8,4.0)
func wall_bay(pos: Vector3,yaw: float,upper:=false) -> void:
	s("WallAstra_Straight_Flat",pos,Vector3(1,1,0.5),yaw)
	s("TopCables_Straight",pos+Vector3(0,3,0),Vector3(0.7,0.5,0.5),yaw)
	s("BottomMetal_Straight",pos+Vector3(0,0.02,0),Vector3(0.55,1,0.5),yaw)
func route(pos: Vector3,yaw:=0.0,length:=1.0) -> void:
	var n:=s("Decal_Line_Straight",pos,Vector3(0.75,1,length),yaw)
	for mesh in n.find_children("*","MeshInstance3D",true,false):
		for i in mesh.mesh.get_surface_count():
			var m: StandardMaterial3D=mesh.get_active_material(i).duplicate();m.albedo_color=Color("55ccde");m.emission_enabled=true;m.emission=Color("24626e");m.emission_energy_multiplier=0.4;mesh.set_surface_override_material(i,m)
func build() -> void:
	direction="facility";art=Node3D.new();art.name="Facility07"
	section("ContinuousPanelFloor")
	for x in range(-14,15,4):
		for z in range(-14,15,4):
			s("Platform_3Plates" if abs(x)<4 else "Platform_CenterPlate",Vector3(x,0,z))
	# Keep all three movement tests readable with actual flush modular landing decks.
	var lab: Node3D=load("res://demo/controller_lab.tscn").instantiate()
	for body in lab.get_node("World").get_children():
		if not body is StaticBody3D:continue
		if not body.name.begins_with("Jump") and not body.name.begins_with("Step"):continue
		var dimensions: Vector3=body.get_node("Collision").shape.size
		s("Platform_Metal2",body.position+Vector3(0,dimensions.y*0.5+0.003,0),Vector3(dimensions.x/4,1,dimensions.z/4))
	lab.free()
	section("AccessGate")
	s("Door_Frame_SquareTall",Vector3(0,0,-4),Vector3(0.55,0.53,1.2))
	for x in [-1.17,1.17]:
		s("Column_Simple",Vector3(x,0,-4),Vector3(0.55,0.53,0.55))
		luminaire(Vector3(x,2.30,-3.65),90)
	s("Prop_Computer",Vector3(-2.15,0,-3.80),Vector3.ONE,20,true)
	s("Prop_AccessPoint",Vector3(1.33,1.1,-3.64),Vector3(0.70,0.70,0.26),90)
	label3("07  /  ACCESS",Vector3(0,2.50,-3.67),0,Color("bbf4ff"),36)
	e("Prop_Crate",Vector3(-2.42,0,-5.05),0.60,-5,true)
	e("Prop_Ammo_Small",Vector3(-2.42,0.90,-5.05),0.9,12)
	e("Prop_Barrel2_Closed",Vector3(2.15,0,-4.26),1.05,15,true)
	e("Prop_HealthPack",Vector3(2.16,0.81,-4.27),0.55)
	s("Prop_Cable_1",Vector3(-2.05,0.01,-2.75),Vector3.ONE*0.7,15)
	for z in [-8.0,-4.0,0.0,4.0,8.0,12.0]: route(Vector3(-0.84,0.008,z))
	section("TransferRamp")
	var ramp:=Transform3D(Basis(Vector3.RIGHT,deg_to_rad(18.43495)),Vector3(-6,0.85,-3))
	for row in 2:
		var n:=s("Platform_Metal",Vector3.ZERO,Vector3.ONE)
		n.transform=ramp*Transform3D(Basis.from_scale(Vector3(0.75,1,0.7906125)),Vector3(0,0.151,-1.581225+row*3.16245))
	for side in [-1.0,1.0]:
		collision_box("RampGuard",Vector3(-6+side*1.65,1.5,-3),Vector3(0.10,1.1,6.32),Vector3(18.43495,0,0))
		for row in 3:
			var z: float=-1.0-row*2.0
			var n:=s("Prop_Rail_2",Vector3.ZERO)
			var b:=bounds(n)
			var pose:=Basis(Vector3.RIGHT,deg_to_rad(18.43495))*Basis.from_scale(Vector3(1,1,1.083))
			n.basis=pose;n.position=Vector3(-6+side*1.60,-z/3+0.08,z)-pose*Vector3(b.get_center().x,b.position.y,b.get_center().z)
	s("Platform_Metal",Vector3(-6,2.003,-7),Vector3(0.75,1,0.5))
	for side in [-1.0,1.0]:
		s("ShortWall_MetalPlates_Straight",Vector3(-6+side*1.5,0,-7),Vector3(1,2,0.5),180 if side>0 else 0)
		s("Prop_Rail_2",Vector3(-6+side*1.60,2,-7),Vector3(1,1,1.03))
	s("ShortWall_MetalPlates_Straight",Vector3(-6,0,-8),Vector3(1,2,0.75),-90)
	s("Prop_Rail_3",Vector3(-6,2,-8.1),Vector3.ONE,-90)
	collision_box("LandingBackGuard",Vector3(-6,2.5,-8.15),Vector3(3.2,1,0.1))
	e("Prop_Crate_Tarp",Vector3(-6.90,2,-7.28),0.56,0,true)
	e("Prop_Ammo_Closed",Vector3(-5.05,2,-7.35),0.9,12)
	e("Prop_Crate_Tarp_Large",Vector3(-8.88,0,-5.05),0.62,90,true)
	e("Prop_Crate",Vector3(-8.78,0.98,-5.40),0.45,5)
	s("Prop_Barrel_Large",Vector3(-8.6,0,-3.4),Vector3.ONE,25,true)
	for x in [-7.25,-4.75]:
		var n:=s("Prop_Light_Floor",Vector3(x,0.08,0.0),Vector3.ONE*0.5,90)
		point_light(Vector3(x,0.4,-0.2),Color("71d9ed"),0.4,2.0)
	section("ControlDeskAndMaintenanceBay")
	for i in 5: wall_bay(Vector3(9.96,0,-10+i*2),180)
	for x in [7.0,9.0]:wall_bay(Vector3(x,0,-1),-90)
	for z in [-9.0,-5.0,-1.0]:
		s("Column_Pipes",Vector3(9.65,0,z),Vector3(0.35,0.75,0.35))
		luminaire(Vector3(9.45,2.85,z),90)
	e("Prop_Desk_Medium",Vector3(8.94,0,-6.35),0.95,-90,true)
	# Source terminal is a floor unit; the slim version sits beside the desk.
	s("Prop_Computer",Vector3(8.15,0,-7.60),Vector3(0.90,0.85,0.90),-70,true)
	e("Prop_Chair",Vector3(7.90,0,-6.30),0.72,95,true)
	e("Prop_Mug",Vector3(8.65,0.894,-6.80),1.0,35)
	e("Prop_KeyCard",Vector3(8.72,0.894,-5.90),0.6,30)
	s("Prop_Clamp",Vector3(8.82,0.894,-6.15),Vector3.ONE*0.6,20)
	label3("SERVICE / 07\nPOWER DISTRIBUTION",Vector3(9.82,2.15,-6.25),-90,Color("c1eaf1"),30)
	e("Prop_Locker",Vector3(9.33,0,-9.15),0.84,-90,true)
	e("Prop_Locker",Vector3(9.33,0,-8.25),0.84,-90,true)
	e("Prop_Shelves_WideTall",Vector3(9.35,0,-3.25),0.93,-90,true)
	# Small supplies follow the shelf's measured upper deck surfaces (source y 0.482 / 1.212 / 1.942 / 2.671 m).
	for row in 3:
		for col in 2:
			e("Prop_Ammo_Small",Vector3(9.20,(0.48199+row*0.72981-0.0014384)*0.93,-3.65+col*0.65),0.8,0)
	for z in [-3.75,-3.25,-2.75]:e("Prop_HealthPack_Tube",Vector3(9.18,(2.67142-0.0014384)*0.93,z),0.85)
	e("Prop_Desk_Small",Vector3(8.70,0,-0.05),0.70,0,true)
	e("Prop_HealthPack",Vector3(8.12,0.658,-0.10),0.65)
	e("Prop_Syringe",Vector3(8.45,0.658,-0.08),0.6)
	e("Prop_Mug",Vector3(9.08,0.658,0.02),1.0)
	e("Prop_Barrel1",Vector3(9.65,0,0.12),0.9,25,true)
	e("Prop_Crate_Tarp",Vector3(7.10,0,-0.10),0.52,8,true)
	s("Prop_Cable_1",Vector3(8.85,0.01,-1.95),Vector3.ONE*0.75,20)
	var fan:=s("Prop_Fan_Small",Vector3(9.78,2.25,-3.30),Vector3.ONE*0.60)
	fan.rotation.z=-PI/2
	var propeller:=s("Prop_Fan_Small_Propeller",Vector3(9.72,2.25,-3.30),Vector3.ONE*0.60);propeller.rotation.z=-PI/2
	section("RearUtilityWall")
	for i in 12:
		var x: float=-11.0+i*2.0
		wall_bay(Vector3(x,0,-12),-90)
		if i%2==0:
			s("Column_Simple",Vector3(x-1,0,-11.74),Vector3(0.45,0.80,0.45))
			luminaire(Vector3(x,3.15,-11.60))
	for x in [-8.0,0.0,8.0]: label3("07  /  TRANSFER",Vector3(x,2.1,-11.85),0,Color("8bb2bd"),32)
	section("UtilityClusters")
	for i in 4:
		e("Prop_Barrel2_Closed",Vector3(6.2+i*0.7,0,-10.65),1.0,i*17,true)
	s("Prop_Cable_3",Vector3(-10.7,0.02,-7.1),Vector3.ONE*0.65)
	for x in [-10.0,-9.0,-8.0]:e("Prop_Crate",Vector3(x,0,-10.7),0.58,0,true)
	begin_backdrop();section("ExternalServiceApron")
	for x in range(-38,39,4):
		for z in range(-42,39,4):
			if abs(x)<16 and abs(z)<16:continue
			s("Platform_DarkPlates",Vector3(x,-0.03,z))
	section("ServiceBuildings")
	for spec in [Vector3(-24,0,-26),Vector3(-10,0,-32),Vector3(8,0,-34),Vector3(26,0,-27)]:
		var height_levels:=3 if spec.x<0 else 4
		for level in height_levels:
			for side in 4:
				var basis:=Basis(Vector3.UP,side*PI/2)
				for bay in [-2.0,2.0]:
					s("WallAstra_Straight",spec+Vector3(0,level*3,0)+basis*Vector3(4,0,bay),Vector3.ONE,180+side*90)
		for x in [-2.0,2.0]:
			for z in [-2.0,2.0]:s("Platform_Metal",spec+Vector3(x,height_levels*3,z))
		e("Prop_SatelliteDish",spec+Vector3(0,height_levels*3,0),1.1,-15)
	for x in [-32.0,-16.0,0.0,16.0,32.0]:
		s("Column_Pipes",Vector3(x,0,-21),Vector3(1.2,2.7,1.2))
		point_light(Vector3(x,13.8,-21),Color("62c5e8"),1.0,8.0)
	section("DistantCargo")
	for i in 10:e("Prop_Crate_Tarp_Large",Vector3(-29+i*6,0,-19),1.5,90 if i%2 else 0)
	finish()
