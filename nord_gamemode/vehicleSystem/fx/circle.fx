//
// Example shader - circle.fx
//

//
// Based on code from:
// http://www.geeks3d.com/20130705/shader-library-circle-disc-fake-sphere-in-glsl-opengl-glslhacker/
//

float sCircleHeightInPixel = 100;
float sCircleWidthInPixel = 100;
float sBorderWidthInPixel = 26;
float sAngleStart = -3.14;
float sAngleEnd = 3.14;
float4 sCircleColor = float4(1.0, 0.0, 0.0, 1.0); // Default red color

//------------------------------------------------------------------------------------------
// PixelShaderFunction
//  1. Read from PS structure
//  2. Process
//  3. Return pixel color
//------------------------------------------------------------------------------------------
float4 PixelShaderFunction(float4 Diffuse : COLOR0, float2 TexCoord : TEXCOORD0) : COLOR0
{
    float2 uv = float2( TexCoord.x, TexCoord.y ) - float2( 0.5, 0.5 );

    // Clip unwanted pixels from partial pie
    float angle = atan2( uv.x, -uv.y );  // -PI to +PI
    if ( sAngleStart > sAngleEnd )
    {
        if ( angle < sAngleStart && angle > sAngleEnd )
            return float4(0.0, 0.0, 0.0, 0.0); // Transparent
    }
    else
    {
        if ( angle < sAngleStart || angle > sAngleEnd )
            return float4(0.0, 0.0, 0.0, 0.0); // Transparent
    }

    // Calc border width to use
    float2 vec = normalize( uv );
    float CircleRadiusInPixel = lerp( sCircleWidthInPixel, sCircleHeightInPixel, vec.y * vec.y );
    float borderWidth = sBorderWidthInPixel / CircleRadiusInPixel;

    // Check if pixel is inside circle
    float dist =  sqrt( dot( uv, uv ) );
    if ( ( dist > 0.5 ) || ( dist < 0.5 - borderWidth ) )
        return float4(0.0, 0.0, 0.0, 0.0); // Transparent
    else 
        return sCircleColor * Diffuse; // Apply the circle color
}

//------------------------------------------------------------------------------------------
// Techniques
//------------------------------------------------------------------------------------------
technique tec0
{
    pass P0
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}
