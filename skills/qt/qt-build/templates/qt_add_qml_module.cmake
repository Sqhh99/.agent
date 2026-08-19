# Qt6 only. Prefer this over a .qrc for QML + icons.
# Sample: MusicPlayer / FLiNG-Downloader.

qt_add_executable(${PROJECT_NAME}
    app/main.cpp
    ${BACKEND_SOURCES}
    ${APP_SOURCES}
)

set_source_files_properties(ui/qml/Theme.qml PROPERTIES
    QT_QML_SINGLETON_TYPE TRUE
)

qt_add_qml_module(${PROJECT_NAME}
    URI App
    VERSION 1.0
    QML_FILES
        ui/qml/Main.qml
        ui/qml/Theme.qml
    RESOURCES
        resources/icons/app.png
)
