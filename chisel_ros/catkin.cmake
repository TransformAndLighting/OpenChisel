cmake_minimum_required(VERSION 2.8.3)

find_package(catkin REQUIRED COMPONENTS roscpp std_msgs sensor_msgs geometry_msgs tf open_chisel message_generation pcl_ros)

find_package(cmake_modules REQUIRED)
find_package(Eigen REQUIRED)
include_directories(${Eigen_INCLUDE_DIRS})
SET(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --std=c++0x")

add_message_files(FILES
  ChunkMessage.msg
  ChunkListMessage.msg
)

add_service_files(FILES
  GetAllChunksService.srv
  PauseService.srv
  ResetService.srv
  SaveMeshService.srv
)

generate_messages(DEPENDENCIES std_msgs sensor_msgs geometry_msgs)

catkin_package(CATKIN_DEPENDS roscpp tf message_runtime std_msgs sensor_msgs open_chisel pcl_ros
	 	INCLUDE_DIRS include
               	LIBRARIES ${PROJECT_NAME})


include_directories(include ${catkin_INCLUDE_DIRS})

add_library(${PROJECT_NAME} src/ChiselServer.cpp)
target_link_libraries(${PROJECT_NAME} ${catkin_LIBRARIES})
add_executable(ChiselNode src/ChiselNode.cpp)
target_link_libraries(ChiselNode ${PROJECT_NAME} ${catkin_LIBRARIES})

install(DIRECTORY include/${PROJECT_NAME}/
  DESTINATION ${CATKIN_PACKAGE_INCLUDE_DESTINATION}
  PATTERN ".git" EXCLUDE
)