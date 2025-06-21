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

(declare-sort var2495 0)
(declare-sort var1597 0)
(declare-sort var2967 0)
(declare-sort var3142 0)
(declare-sort var1496 0)
(declare-sort var3538 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isClosing/-765312614 (var2967) Bool)
(declare-fun cast-from-var2495-to-var2967 (var2495) var2967)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var1496) String)
(declare-fun cast-from-var1597-to-var1496 (var1597) var1496)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3142_warn/1431914100 (var3142 String String String String) void)
(declare-fun var3538_close/-720329067 (var3538) void)
(declare-fun cast-from-var1597-to-var3538 (var1597) var3538)
(declare-const null-var2495 var2495)
(declare-const null-var1597 var1597)
(declare-const var2495-logger var3142)
(declare-const var223 var2495) ; Statement: r0 := @this: org.apache.dubbo.remoting.transport.AbstractServer 
(assert (not (= var223 null-var2495)))
(declare-const var3178 var1597) ; Statement: r3 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3178 null-var1597)))
(assert true)
(define-const var3675 Bool (isClosing/-765312614 (cast-from-var2495-to-var2967 var223))) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: boolean isClosing()>() 
 ; Statement: if $z0 != 0 goto $r2 = <org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(assert (not (= (ite var3675 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3434 var3142 var2495-logger) ; Statement: $r2 = <org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2816 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2816)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2816!1 String)
(assert (= var2816!1 ""))
(assert true)
(define-const var1425 String (append/672562846 var2816!1 "Close new channel ")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Close new channel ") 
(declare-const var2816!2 String)
(assert (= var2816!2 (str.++ var2816!1 "Close new channel ")))
(assert true)
(define-const var727 String (append/-1031950772 var1425 (cast-from-var1597-to-var1496 var3178))) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3) 
(declare-const var1425!1 String)
(assert (str.prefixof var1425 var1425!1))
(assert true)
(define-const var2799 String (append/672562846 var727 ", cause: server is closing or has been closed. For example, receive a new connect request while in shutdown process.")) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: server is closing or has been closed. For example, receive a new connect request while in shutdown process.") 
(declare-const var727!1 String)
(assert (= var727!1 (str.++ var727 ", cause: server is closing or has been closed. For example, receive a new connect request while in shutdown process.")))
(assert true)
(define-const var1966 String (toString/-2075883882 var2799)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var3142_warn/1431914100 var3434 "99-0" "unknown error in remoting module" "" var1966)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "unknown error in remoting module", "", $r7) 

(declare-const var3434!1 var3142)
(declare-const var1312 String)
(declare-const var2043 String)
(declare-const var1192 String)
(declare-const var1966!1 String)
;(assert (var3538_close/-720329067 (cast-from-var1597-to-var3538 var3178))) ; Statement: interfaceinvoke r3.<org.apache.dubbo.remoting.Channel: void close()>() 

(declare-const var3178!1 var1597)
 ; Statement: return 
(check-sat)
; {isClosing/-765312614=([org.apache.dubbo.remoting.transport.AbstractPeer], boolean), cast-from-var2495-to-var2967=([org.apache.dubbo.remoting.transport.AbstractServer], org.apache.dubbo.remoting.transport.AbstractPeer), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1597-to-var1496=([org.apache.dubbo.remoting.Channel], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3142_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), var3538_close/-720329067=([org.apache.dubbo.remoting.Endpoint], void), cast-from-var1597-to-var3538=([org.apache.dubbo.remoting.Channel], org.apache.dubbo.remoting.Endpoint)}
; {var2495=org.apache.dubbo.remoting.transport.AbstractServer, var223=r0, var1597=org.apache.dubbo.remoting.Channel, var3178=r3, var2967=org.apache.dubbo.remoting.transport.AbstractPeer, var3675=$z0, var3142=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var3434=$r2, var2816=$r1, var1425=$r4, var1496=java.lang.Object, var727=$r5, var2799=$r6, var1966=$r7, var1312="99-0", var2043="unknown error in remoting module", var1192="", var3538=org.apache.dubbo.remoting.Endpoint}
; {org.apache.dubbo.remoting.transport.AbstractServer=var2495, r0=var223, org.apache.dubbo.remoting.Channel=var1597, r3=var3178, org.apache.dubbo.remoting.transport.AbstractPeer=var2967, $z0=var3675, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var3142, $r2=var3434, $r1=var2816, $r4=var1425, java.lang.Object=var1496, $r5=var727, $r6=var2799, $r7=var1966, "99-0"=var1312, "unknown error in remoting module"=var2043, ""=var1192, org.apache.dubbo.remoting.Endpoint=var3538}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.remoting.transport.AbstractServer;	r3 := @parameter0: org.apache.dubbo.remoting.Channel;	$z0 = virtualinvoke r0.<org.apache.dubbo.remoting.transport.AbstractServer: boolean isClosing()>();	if $z0 != 0 goto $r2 = <org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r2 = <org.apache.dubbo.remoting.transport.AbstractServer: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Close new channel ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r3);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", cause: server is closing or has been closed. For example, receive a new connect request while in shutdown process.");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("99-0", "unknown error in remoting module", "", $r7);	interfaceinvoke r3.<org.apache.dubbo.remoting.Channel: void close()>();	return
;block_num 2