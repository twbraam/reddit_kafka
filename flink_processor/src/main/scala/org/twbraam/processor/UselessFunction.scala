package org.twbraam.processor

import org.apache.flink.api.common.functions.MapFunction

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