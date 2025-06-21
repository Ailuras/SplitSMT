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

(declare-sort var3854 0)
(declare-sort var3541 0)
(declare-sort var2392 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun h2StreamChannel/456568354 (var3854) var3541)
(declare-fun append/-1031950772 (String var2392) String)
(declare-fun cast-from-var3541-to-var2392 (var3541) var2392)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3854 var3854)
(declare-const var3739 var3854) ; Statement: r1 := @this: org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate 
(assert (not (= var3739 null-var3854)))
(define-const var3555 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3555)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3555!1 String)
(assert (= var3555!1 ""))
(assert true)
(define-const var1685 String (append/672562846 var3555!1 "Http2ChannelDelegate{h2StreamChannel=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http2ChannelDelegate{h2StreamChannel=") 
(declare-const var3555!2 String)
(assert (= var3555!2 (str.++ var3555!1 "Http2ChannelDelegate{h2StreamChannel=")))
(define-const var3950 var3541 (h2StreamChannel/456568354 var3739)) ; Statement: $r2 = r1.<org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate: org.apache.dubbo.remoting.http12.h2.H2StreamChannel h2StreamChannel> 
(assert true)
(define-const var1250 String (append/-1031950772 var1685 (cast-from-var3541-to-var2392 var3950))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1685!1 String)
(assert (str.prefixof var1685 var1685!1))
(assert true)
(define-const var3756 String (append/-1166366385 var1250 125)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1250!1 String)
(assert (str.prefixof var1250 var1250!1))
(assert true)
(define-const var995 String (toString/-2075883882 var3756)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), h2StreamChannel/456568354=([org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate], org.apache.dubbo.remoting.http12.h2.H2StreamChannel), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var3541-to-var2392=([org.apache.dubbo.remoting.http12.h2.H2StreamChannel], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3854=org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate, var3739=r1, var3555=$r0, var1685=$r3, var3541=org.apache.dubbo.remoting.http12.h2.H2StreamChannel, var3950=$r2, var2392=java.lang.Object, var1250=$r4, var3756=$r5, var995=$r6}
; {org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate=var3854, r1=var3739, $r0=var3555, $r3=var1685, org.apache.dubbo.remoting.http12.h2.H2StreamChannel=var3541, $r2=var3950, java.lang.Object=var2392, $r4=var1250, $r5=var3756, $r6=var995}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Http2ChannelDelegate{h2StreamChannel=");	$r2 = r1.<org.apache.dubbo.remoting.http12.h2.Http2ChannelDelegate: org.apache.dubbo.remoting.http12.h2.H2StreamChannel h2StreamChannel>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 1