cmake_minimum_required(VERSION 3.5)

project(openchisel)

set(CMAKE_CXX_FLAGS "-std=c++11 -stdlib=libc++")

set(HEADERS
)

set(SOURCES
	src/camera/Intrinsics.cpp
	src/camera/PinholeCamera.cpp
	src/io/PLY.cpp
	src/marching_cubes/MarchingCubes.cpp
	src/mesh/Mesh.cpp
	src/geometry/AABB.cpp
	src/geometry/Frustum.cpp
	src/geometry/Plane.cpp
	src/geometry/Raycast.cpp
	src/pointcloud/PointCloud.cpp
	src/Chisel.cpp
	src/Chunk.cpp
	src/ChunkManager.cpp
	src/ColorVoxel.cpp
	src/DistVoxel.cpp
	src/ProjectionIntegrator.cpp
)

add_library                (${PROJECT_NAME} STATIC ${HEADERS} ${SOURCES})

include_directories        (${EIGEN_INCLUDE_DIR})
target_compile_definitions (${PROJECT_NAME} PUBLIC EIGEN_DONT_VECTORIZE=1 EIGEN_DISABLE_UNALIGNED_ARRAY_ASSERT=1)
target_include_directories (${PROJECT_NAME} PUBLIC include)

set_target_properties      (${PROJECT_NAME} PROPERTIES DEBUG_POSTFIX "d")
set_property               (TARGET ${PROJECT_NAME} PROPERTY FOLDER "openchisel")

INSTALL(TARGETS ${PROJECT_NAME}
	RUNTIME DESTINATION bin
	LIBRARY DESTINATION lib
	ARCHIVE DESTINATION lib
)

INSTALL(DIRECTORY include/open_chisel
	DESTINATION include
)
