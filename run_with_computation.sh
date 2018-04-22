#!/bin/bash
docker run -p 17876:17876 -p 17874:17874 -p 16876:16876 -p 16874:16874  --mount type=bind,source="$(pwd)"/xel_data_dir,target=/elastic-core-maven/nxt_test_db --mount type=bind,source="$(pwd)"/conf,target=/elastic-core-maven/conf_user -i -t xel
