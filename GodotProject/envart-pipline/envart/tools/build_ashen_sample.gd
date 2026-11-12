extends "res://envart/tools/build_direction_base.gd"
func torch(pos: Vector3,yaw:=0.0) -> void:
	k("torch_mounted",pos,0.65,yaw)
	point_light(pos+Vector3(0,0.52,0),Color("ffac60"),1.7,4.2)
func candles(pos: Vector3,count:=3) -> void:
	for i in count: k("candle_lit" if i%2==0 else "candle_melted",pos+Vector3((i%2)*0.15,0,(i/2)*0.13),0.22+0.05*(i%3),i*47.0)
	point_light(pos+Vector3(0,0.25,0),Color("ffc889"),0.45,1.8)
func build() -> void:
	direction="ashen";art=Node3D.new();art.name="AshenCourtyard"
	section("ContinuousStoneCourt")
	for x in range(-15,16,2):
		for z in range(-15,16,2):
			var index:=absi(x*7+z*11)%11
			var model: String="floor_tile_small" if index<8 else ("floor_tile_small_broken_A" if index%2==0 else "floor_tile_small_broken_B")
			# Actual stone meshes: highest surface is at the original collision plane.
			k(model,Vector3(x,-0.15,z),1.0,90.0*(index%4))
	section("GatehouseAndVotiveObjects")
	var door:=asset("kaykit_dungeon","wall_doorway",Vector3(0,0,-4),Vector3(0.66,0.85,0.60),0,false,false)
	# The source includes a separate animated door leaf; keep only the arch.
	for child in door.find_children("*door*","MeshInstance3D",true,false):
		if child.name=="wall_doorway_door": child.hide()
	for x in [-1.12,1.12]:
		asset("kaykit_dungeon","pillar",Vector3(x,0,-4),Vector3(0.34,0.82,0.40))
		torch(Vector3(x,1.43,-3.65))
	asset("kaykit_dungeon","banner_thin_brown",Vector3(-1.5,1.15,-4.0),Vector3(0.32,0.60,0.32),0)
	k("sword_shield_broken",Vector3(-2.12,0,-4.00),0.60,-15,true)
	k("chest",Vector3(-2.60,0,-4.82),0.62,7,true)
	candles(Vector3(-2.16,0,-3.47),4)
	asset("quaternius_props","Vase_4",Vector3(2.12,0,-4.30),Vector3.ONE*0.8,10,true)
	asset("quaternius_props","Vase_Rubble_Medium",Vector3(2.55,0,-3.83),Vector3.ONE*0.8,-20)
	candles(Vector3(1.80,0,-3.75),3)
	section("StoneCauseway")
	var ramp_transform:=Transform3D(Basis(Vector3.RIGHT,deg_to_rad(18.43495)),Vector3(-6,0.85,-3))
	for row in 4:
		var n:=asset("kaykit_dungeon","floor_tile_small",Vector3.ZERO,Vector3.ONE,0,false,false)
		n.transform=ramp_transform*Transform3D(Basis.from_scale(Vector3(1.5,1,0.7906125)),Vector3(0,0.10,-2.3718375+row*1.581225))
	for side in [-1.0,1.0]:
		collision_box("CausewayGuard",Vector3(-6+side*1.72,1.5,-3),Vector3(0.15,1.1,6.32),Vector3(18.43495,0,0))
		for row in 3:
			var z: float=-1.0-row*2.0
			var rail:=asset("kaykit_dungeon","barrier",Vector3.ZERO,Vector3.ONE,0,false,false)
			rail.basis=Basis(Vector3.UP,PI/2)*Basis(Vector3.FORWARD,deg_to_rad(-18.43495))*Basis.from_scale(Vector3(0.52705,0.72,0.38))
			rail.position=Vector3(-6+side*1.65,-z/3+0.02,z)
	asset("kaykit_dungeon","floor_tile_small",Vector3(-6,1.85,-7),Vector3(1.5,1,1))
	for side in [-1.0,1.0]:
		asset("kaykit_dungeon","wall",Vector3(-6+side*1.55,0,-7),Vector3(0.50,0.50,0.20),90)
		asset("kaykit_dungeon","barrier",Vector3(-6+side*1.66,2,-7),Vector3(0.5,0.72,0.38),90)
	asset("kaykit_dungeon","wall",Vector3(-6,0,-8),Vector3(0.75,0.5,0.25))
	asset("kaykit_dungeon","barrier",Vector3(-6,2,-8.12),Vector3(0.75,0.72,0.38))
	collision_box("LandingBackGuard",Vector3(-6,2.5,-8.15),Vector3(3.2,1,0.1))
	k("chest",Vector3(-6.90,2,-7.25),0.48,-5,true)
	candles(Vector3(-5.05,2,-7.44),3)
	k("crates_stacked",Vector3(-8.68,0,-5.40),0.65,-6,true)
	k("barrel_large_decorated",Vector3(-8.72,0,-3.95),0.46,18,true)
	k("rubble_half",Vector3(-8.30,0,-1.55),0.23,35)
	section("ReliquaryAndAbandonedGuardPost")
	for i in 5:
		var z: float=-10.0+i*2.0
		asset("kaykit_dungeon",["wall_archedwindow_gated","wall_arched","wall_cracked","wall_arched","wall_archedwindow_gated"][i],Vector3(10,0,z),Vector3(0.5,0.75,0.45),-90)
		if i%2==0: asset("kaykit_dungeon","pillar",Vector3(9.74,0,z+1.0),Vector3(0.34,0.80,0.34))
	for x in [7.0,9.0]: asset("kaykit_dungeon","wall_arched",Vector3(x,0,-1),Vector3(0.5,0.75,0.5))
	k("table_medium",Vector3(9.03,0,-6.15),0.66,0,true)
	k("sword_shield",Vector3(9.62,1.05,-6.15),0.48,-90)
	candles(Vector3(8.83,0.66,-6.36),5)
	asset("quaternius_props","Book_5",Vector3(8.76,0.66,-5.85),Vector3.ONE*0.48,25)
	k("shelf_small_candles",Vector3(9.67,1.85,-7.15),0.75,-90)
	torch(Vector3(9.62,1.98,-5.03),-90)
	k("table_long_broken",Vector3(8.60,0,-3.25),0.52,90,true)
	k("stool",Vector3(7.65,0,-3.75),1.0,-15,true)
	k("bottle_A_brown",Vector3(8.42,0.65,-3.25),0.45)
	k("plate_stack",Vector3(9.02,0.65,-3.30),0.4)
	k("chest",Vector3(9.03,0,-8.45),0.70,-90,true)
	k("barrel_small_stack",Vector3(7.77,0,-8.75),0.65,-20,true)
	k("trunk_medium_B",Vector3(8.17,0,-0.15),0.85,8,true)
	k("sword_shield_broken",Vector3(9.18,0,-0.35),0.55,15,true)
	candles(Vector3(7.55,0,-0.35),3)
	k("rubble_large",Vector3(9.12,0,0.25),0.12,-15)
	section("GuardPostSmallObjects")
	asset("quaternius_props","Chain_Coil",Vector3(8.65,0,-7.22),Vector3.ONE*0.55,30)
	asset("quaternius_props","Bucket_Metal",Vector3(7.98,0,-5.77),Vector3.ONE*0.70,-10,true)
	asset("quaternius_props","Scroll_2",Vector3(9.17,0.66,-6.40),Vector3.ONE*0.55,-18)
	asset("quaternius_props","Pouch_Large",Vector3(8.74,0.66,-6.64),Vector3.ONE*0.6,15)
	asset("quaternius_props","Book_5",Vector3(9.10,0.66,-6.00),Vector3.ONE*0.5,-12)
	asset("quaternius_props","Rope_1",Vector3(-8.72,1.17,-3.95),Vector3.ONE*0.62,20)
	asset("quaternius_props","Bag",Vector3(-8.35,0,-4.45),Vector3.ONE*0.78,30,true)
	asset("quaternius_props","Vase_Rubble_Medium",Vector3(9.10,0,-4.60),Vector3.ONE*0.7,-40)
	asset("quaternius_props","Mug",Vector3(8.95,0.65,-3.65),Vector3.ONE*0.75,20)
	k("rubble_half",Vector3(9.20,0,-2.15),0.14,20)
	for pos in [Vector3(8.2,0,-0.5),Vector3(9.2,0,-4.5),Vector3(-2.6,0,-5.2)]:
		for i in 4: asset("quaternius_nature","Grass_Wispy_Short",pos+Vector3(i*0.13,0,(i%2)*0.2),Vector3.ONE*(0.15+i*0.015),i*43.0)
	section("CurtainWall")
	for i in 12:
		var x: float=-11.0+i*2.0
		asset("kaykit_dungeon","wall_cracked" if i%4==0 else "wall_arched",Vector3(x,0,-12),Vector3(0.5,1,0.50))
		if i%2==0: asset("kaykit_dungeon","pillar",Vector3(x-1,0,-11.7),Vector3(0.4,1.05,0.4))
		k("column",Vector3(x,4,-12),0.65)
	for x in [-9.0,-1.0,7.0]: torch(Vector3(x,2.1,-11.65))
	section("RubbleAndDryGrowth")
	var random:=RandomNumberGenerator.new();random.seed=20817
	for line in [Vector3(-10,0,-11),Vector3(-8.25,0,-6),Vector3(9.2,0,-9),Vector3(9.3,0,-2)]:
		for i in 8:
			var pos: Vector3=line+Vector3(random.randf_range(-0.35,0.35),0,random.randf_range(-1,1))
			asset("quaternius_nature","Grass_Wispy_Short",pos,Vector3.ONE*random.randf_range(0.12,0.24),random.randf_range(0,360))
	for pos in [Vector3(-10.8,0,-10.6),Vector3(-4.2,0,-11.1),Vector3(4.4,0,-11.0),Vector3(9,0,-9.2),Vector3(-9,0,-7.7)]: k("rubble_large",pos,0.19,random.randf_range(0,360))
	begin_backdrop();section("AshWastes");ash_terrain()
	section("DistantFortress")
	var tower_index:=0
	for spec in [Vector3(-20,1,-32),Vector3(-8,1,-37),Vector3(8,1,-37),Vector3(24,1,-32)]:
		var levels: int=[3,5,4,3][tower_index];tower_index+=1
		for level in levels:
			for side in 4:
				var b:=Basis(Vector3.UP,side*PI/2)
				asset("kaykit_dungeon","wall_archedwindow_open",spec+Vector3(0,level*4,0)+b*Vector3(0,0,3),Vector3(1.5,1,0.85),side*90.0)
		for side in 4:
			var b:=Basis(Vector3.UP,side*PI/2)
			asset("kaykit_dungeon","barrier_column",spec+Vector3(0,levels*4,0)+b*Vector3(0,0,3),Vector3(1.5,1,1),side*90.0)
	for i in 9: asset("kaykit_dungeon","wall_broken" if i%3==1 else "wall_arched",Vector3(-16+i*4,1,-35),Vector3(1,1.8,1.4))
	section("ScreeRocks")
	for i in 25:
		var x:=random.randf_range(-50,50);var z:=random.randf_range(-55,-24)
		asset("quaternius_nature","Rock_Medium_1",Vector3(x,terrain_height(x,z)-1.1,z),Vector3.ONE*random.randf_range(0.7,1.5),random.randf_range(0,360))
	finish()
