

<a id='6'></a>
# 6️⃣ Create the Flow in the AI Studio Project (optional)

```

! pfazure flow create --flow {flow_name} --set display_name={flow_name} type=chat description="Basic Chat Flow" -g {resource_group_name} -w {ml_project_name}

File "c:\Users\u3184\azdevops\pevosdcgh\AI-Gateway\.venv\Lib\site-packages\promptflow\_sdk\_telemetry\activity.py", line 265, in wrapper
    return f(self, *args, **kwargs)

ErrorCode:AuthorizationFailure
Content: <?xml version="1.0" encoding="utf-8"?><Error><Code>AuthorizationFailure</Code><Message>This request is not authorized to perform this operation.
RequestId:901deb76-b01a-004f-2fc6-26405d000000
Time:2024-10-25T10:14:52.0956013Z</Message></Error>

```

See:
- [microsoft](https://github.com/microsoft/promptflow/issues/1994)