(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var595 0)
(declare-sort var550 0)
(declare-sort var2859 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun channel/880114583 (var595) var550)
(declare-fun append/-1031950772 (String var2859) String)
(declare-fun cast-from-var550-to-var2859 (var550) var2859)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var595 var595)
(declare-const var517 var595) ; Statement: r1 := @this: org.apache.dubbo.remoting.transport.netty.NettyChannel 
(assert (not (= var517 null-var595)))
(define-const var2666 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2666)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2666!1 String)
(assert (= var2666!1 ""))
(assert true)
(define-const var1500 String (append/672562846 var2666!1 "NettyChannel [channel=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NettyChannel [channel=") 
(declare-const var2666!2 String)
(assert (= var2666!2 (str.++ var2666!1 "NettyChannel [channel=")))
(define-const var3151 var550 (channel/880114583 var517)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.transport.netty.NettyChannel: org.jboss.netty.channel.Channel channel> 
(assert true)
(define-const var1304 String (append/-1031950772 var1500 (cast-from-var550-to-var2859 var3151))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1500!1 String)
(assert (str.prefixof var1500 var1500!1))
(assert true)
(define-const var26 String (append/672562846 var1304 "]")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var1304!1 String)
(assert (= var1304!1 (str.++ var1304 "]")))
(assert true)
(define-const var1302 String (toString/-2075883882 var26)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), channel/880114583=([org.apache.dubbo.remoting.transport.netty.NettyChannel], org.jboss.netty.channel.Channel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var550-to-var2859=([org.jboss.netty.channel.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var595=org.apache.dubbo.remoting.transport.netty.NettyChannel, var517=r1, var2666=$r0, var1500=$r3, var550=org.jboss.netty.channel.Channel, var3151=$r2, var2859=java.lang.Object, var1304=$r4, var26=$r5, var1302=$r6}
; {org.apache.dubbo.remoting.transport.netty.NettyChannel=var595, r1=var517, $r0=var2666, $r3=var1500, org.jboss.netty.channel.Channel=var550, $r2=var3151, java.lang.Object=var2859, $r4=var1304, $r5=var26, $r6=var1302}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.transport.netty.NettyChannel;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NettyChannel [channel=");	$r2 = r1.<org.apache.dubbo.remoting.transport.netty.NettyChannel: org.jboss.netty.channel.Channel channel>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1