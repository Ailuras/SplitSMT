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

(declare-sort var3291 0)
(declare-sort var3989 0)
(declare-sort var2179 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun channel/-724753453 (var3291) var3989)
(declare-fun append/-1031950772 (String var2179) String)
(declare-fun cast-from-var3989-to-var2179 (var3989) var2179)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3291 var3291)
(declare-const var3473 var3291) ; Statement: r1 := @this: org.apache.dubbo.remoting.transport.netty4.NettyChannel 
(assert (not (= var3473 null-var3291)))
(define-const var812 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var812)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var812!1 String)
(assert (= var812!1 ""))
(assert true)
(define-const var2698 String (append/672562846 var812!1 "NettyChannel [channel=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NettyChannel [channel=") 
(declare-const var812!2 String)
(assert (= var812!2 (str.++ var812!1 "NettyChannel [channel=")))
(define-const var832 var3989 (channel/-724753453 var3473)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: io.netty.channel.Channel channel> 
(assert true)
(define-const var3163 String (append/-1031950772 var2698 (cast-from-var3989-to-var2179 var832))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2698!1 String)
(assert (str.prefixof var2698 var2698!1))
(assert true)
(define-const var2564 String (append/672562846 var3163 "]")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]") 
(declare-const var3163!1 String)
(assert (= var3163!1 (str.++ var3163 "]")))
(assert true)
(define-const var25 String (toString/-2075883882 var2564)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), channel/-724753453=([org.apache.dubbo.remoting.transport.netty4.NettyChannel], io.netty.channel.Channel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3989-to-var2179=([io.netty.channel.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3291=org.apache.dubbo.remoting.transport.netty4.NettyChannel, var3473=r1, var812=$r0, var2698=$r3, var3989=io.netty.channel.Channel, var832=$r2, var2179=java.lang.Object, var3163=$r4, var2564=$r5, var25=$r6}
; {org.apache.dubbo.remoting.transport.netty4.NettyChannel=var3291, r1=var3473, $r0=var812, $r3=var2698, io.netty.channel.Channel=var3989, $r2=var832, java.lang.Object=var2179, $r4=var3163, $r5=var2564, $r6=var25}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.transport.netty4.NettyChannel;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("NettyChannel [channel=");	$r2 = r1.<org.apache.dubbo.remoting.transport.netty4.NettyChannel: io.netty.channel.Channel channel>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("]");	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1