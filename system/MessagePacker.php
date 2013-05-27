<?php
/**
 * ARSoft Core platform
 *
 * Copyright (c) 2013 - Alexandru Rusu. All Right Reserved.
 * This software is the property of it's author(s).
 *     Website: http://alexrusu.ro
 *     Email:   andu.rusu@gmail.com
 *
 * This class provides two static methods to compress / un-compress the accessible
 * parts of various PHP values (scalar values, arrays and public attributes of the
 * objects). It is mainly used to create highly-accessible data to be kept in the
 * SQL tables - for example: keep a de-normalized cache of multiple and various
 * normalized data for the records used by the application. The cache storage must
 * be rebuilt when the normalized properties are accessed, but provides much faster
 * response time for data access in read-only mode by avoiding joins or secondary
 * database queries as much as possible. Usage example:
 *
 * <code>
 *     require_once BASE_PATH . '/system/MessagePacker.php';
 *     $someObject = array(
 *         "test1" => "testValue1",
 *         "test2" => "testValue2",
 *         "test3" => "testValue3",
 *         "test4" => "testValue4",
 *     );
 *     $packed = MessagePacker::messagePack($someObject);    // Pack an object, store $packed in the database
 *     $unpacked =  MessagePacker::messageUnpack($packed);   // Unpack an object, the result is $someObject
 * </code>
 *
 * @category   System
 * @package    Global
 * @subpackage MessagePacker
 * @copyright  Copyright (c) 2013 - Alexandru Rusu
 * @author     Alexandru Rusu <andu.rusu@gmail.com>
 * @version    $Id$
 */
class MessagePacker
{
    /**
     * Pack an object by applying the following operations in order (the level of compression is defined as highest by default):
     * 1. Serialize the initial object
     * 2. Compress the object using the ZIP algorithm at the (provided) compression level
     * 3. Encode the resulting archive as a Base64 string for web-safe transfer & database storage
     *
     * @param mixed   $value       The object to be packed
     * @param integer $compression (optional) Zip compression level
     * @return string The packed object
     */
    public static function messagePack($value, $compression = 9)
    {
        return base64_encode(gzdeflate(serialize($value), $compression));
    }

    /**
     * Unpack an object that was packed using the previous method. The resulted object is returned
     * untouched if the provided value is not a string.
     *
     * @param string|mixed $value The object to be unpacked
     * @return mixed The original object
     */
    public static function messageUnpack($value)
    {
        return (is_string($value)) ? unserialize(gzinflate(base64_decode($value))) : $value;
    }
}

/* EOF */