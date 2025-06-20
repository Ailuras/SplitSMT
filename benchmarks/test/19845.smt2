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

(declare-sort var3238 0)
(declare-sort var653 0)
(declare-sort var1658 0)
(declare-sort var494 0)
(declare-sort var264 0)
(declare-sort var1383 0)
(declare-sort var3108 0)
(declare-sort var3678 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var653_removeAttribute/-1356724306 (var653 String) void)
(declare-fun var1658_isNotEmpty/-1251449450 (String) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getName/-1958580599 (ClassObject) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var3108_get/1088891777 (var3108 var1383) var1383)
(declare-fun cast-from-var494-to-var3108 (var494) var3108)
(declare-fun cast-from-String-to-var1383 (String) var1383)
(declare-fun cast-from-var1383-to-var3678 (var1383) var3678)
(declare-const null-ClassObject ClassObject)
(declare-const null-String String)
(declare-const null-var653 var653)
(declare-const var264-TRACERS var494)
(declare-const null-var3678 var3678)
(declare-const var1023 ClassObject) ; Statement: r2 := @parameter0: java.lang.Class 
(assert (not (= var1023 null-ClassObject)))
(declare-const var1993 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1993 null-String)))
(declare-const var3548 var653) ; Statement: r0 := @parameter2: org.apache.dubbo.remoting.Channel 
(assert (not (= var3548 null-var653)))
;(assert (var653_removeAttribute/-1356724306 var3548 "trace.max")) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.max") 

(declare-const var3548!1 var653)
(declare-const var901 String)
;(assert (var653_removeAttribute/-1356724306 var3548!1 "trace.count")) ; Statement: interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.count") 

(declare-const var3548!2 var653)
(declare-const var536 String)
(define-const var3940 Bool (var1658_isNotEmpty/-1251449450 var1993)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1) 
 ; Statement: if $z0 == 0 goto $r11 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert (not (= (ite var3940 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2795 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2795)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2795!1 String)
(assert (= var2795!1 ""))
(assert true)
(define-const var3757 String (getName/-1958580599 var1023)) ; Statement: $r6 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>() 
(assert true)
(define-const var1778 String (append/672562846 var2795!1 var3757)) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6) 
(declare-const var2795!2 String)
(assert (= var2795!2 (str.++ var2795!1 var3757)))
(assert true)
(define-const var950 String (append/672562846 var1778 ".")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".") 
(declare-const var1778!1 String)
(assert (= var1778!1 (str.++ var1778 ".")))
(assert true)
(define-const var1280 String (append/672562846 var950 var1993)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var950!1 String)
(assert (= var950!1 (str.++ var950 var1993)))
(assert true)
(define-const var384 String (toString/-2075883882 var1280)) ; Statement: $r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= $r3 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>] 
(assert true) ; Non Conditional
(define-const var795 var494 var264-TRACERS) ; Statement: $r3 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS> 
(define-const var90 var1383 (var3108_get/1088891777 (cast-from-var494-to-var3108 var795) (cast-from-String-to-var1383 var384))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r11) 
(define-const var3372 var3678 (cast-from-var1383-to-var3678 var90)) ; Statement: $r10 = (java.util.Set) $r4 
 ; Statement: if $r10 == null goto return 
(assert (= var3372 null-var3678)) ; Cond: $r10 == null 
 ; Statement: return 
(check-sat)
; {var653_removeAttribute/-1356724306=([org.apache.dubbo.remoting.Channel, java.lang.String], void), var1658_isNotEmpty/-1251449450=([java.lang.String], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getName/-1958580599=([java.lang.Class], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var3108_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var494-to-var3108=([java.util.concurrent.ConcurrentMap], java.util.Map), cast-from-String-to-var1383=([java.lang.String], java.lang.Object), cast-from-var1383-to-var3678=([java.lang.Object], java.util.Set)}
; {var1023=r2, var1993=r1, var3238=null_type, var653=org.apache.dubbo.remoting.Channel, var3548=r0, var901="trace.max", var536="trace.count", var1658=org.apache.dubbo.common.utils.StringUtils, var3940=$z0, var2795=$r5, var3757=$r6, var1778=$r7, var950=$r8, var1280=$r9, var384=$r11, var494=java.util.concurrent.ConcurrentMap, var264=org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter, var795=$r3, var1383=java.lang.Object, var3108=java.util.Map, var90=$r4, var3678=java.util.Set, var3372=$r10}
; {r2=var1023, r1=var1993, null_type=var3238, org.apache.dubbo.remoting.Channel=var653, r0=var3548, "trace.max"=var901, "trace.count"=var536, org.apache.dubbo.common.utils.StringUtils=var1658, $z0=var3940, $r5=var2795, $r6=var3757, $r7=var1778, $r8=var950, $r9=var1280, $r11=var384, java.util.concurrent.ConcurrentMap=var494, org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter=var264, $r3=var795, java.lang.Object=var1383, java.util.Map=var3108, $r4=var90, java.util.Set=var3678, $r10=var3372}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @parameter0: java.lang.Class;	r1 := @parameter1: java.lang.String;	r0 := @parameter2: org.apache.dubbo.remoting.Channel;	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.max");	interfaceinvoke r0.<org.apache.dubbo.remoting.Channel: void removeAttribute(java.lang.String)>("trace.count");	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>(r1);	if $z0 == 0 goto $r11 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke r2.<java.lang.Class: java.lang.String getName()>();	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r6);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(".");	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r11 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= $r3 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>];	$r3 = <org.apache.dubbo.rpc.protocol.dubbo.filter.TraceFilter: java.util.concurrent.ConcurrentMap TRACERS>;	$r4 = interfaceinvoke $r3.<java.util.concurrent.ConcurrentMap: java.lang.Object get(java.lang.Object)>($r11);	$r10 = (java.util.Set) $r4;	if $r10 == null goto return;	return
;block_num 4