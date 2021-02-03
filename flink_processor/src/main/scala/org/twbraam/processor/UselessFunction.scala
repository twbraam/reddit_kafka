package org.twbraam.processor

import com.google.protobuf.any.Any.messageCompanion
import org.apache.flink.api.common.functions.MapFunction
import io.circe._
import scalapb_circe.JsonFormat

import scala.util.matching.Regex

class UselessFunction extends MapFunction[String, Float] {
  override def map(r: String): Float = {
    val pattern = "^.*,title=(.+?),id=.*,link=(.+?),author=.*,date=(.+?)}$".r
    val result = pattern.findFirstMatchIn(r) match {
      case Some(found) => found.subgroups match {
        case List(title, link, timestamp) => Some(title, link, timestamp)
        case _ => None
      }
      case _ => None
    }

    print(result)

    0.001f
  }
}