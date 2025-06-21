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

(declare-sort var3939 0)
(declare-sort var3340 0)
(declare-sort var808 0)
(declare-sort var25 0)
(declare-sort var3737 0)
(declare-sort var2448 0)
(declare-sort var320 0)
(declare-sort var3313 0)
(declare-sort var2960 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isHttp/-1560219278 (var3340) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun serializeCheckUtils/-771221459 (var3939) var808)
(declare-fun getWarnedClasses/-444103701 (var808) var25)
(declare-fun var2448_stream/-1288525013 (var2448) var3737)
(declare-fun cast-from-var25-to-var2448 (var25) var2448)
(declare-fun var3737_sorted/1716554230 (var3737) var3737)
(declare-fun var3313_joining/-1302177485 (String) var320)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3737_collect/-2050842585 (var3737 var320) var2960)
(declare-fun cast-from-var2960-to-String (var2960) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3939 var3939)
(declare-const null-var3340 var3340)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1072 var3939) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.SerializeWarnedClasses 
(assert (not (= var1072 null-var3939)))
(declare-const var1414 var3340) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var1414 null-var3340)))
(declare-const var2660 (Array Int String)) ; Statement: r18 := @parameter1: java.lang.String[] 
(assert (not (= var2660 null-__Array__Int__String__)))
(assert true)
(define-const var1179 Bool (isHttp/-1560219278 var1414)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>() 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (= (ite var1179 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3865 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3865)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3865!1 String)
(assert (= var3865!1 ""))
(assert true)
(define-const var1738 String (append/672562846 var3865!1 "WarnedClasses: \n")) ; Statement: $r10 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("WarnedClasses: \n") 
(declare-const var3865!2 String)
(assert (= var3865!2 (str.++ var3865!1 "WarnedClasses: \n")))
(define-const var1705 var808 (serializeCheckUtils/-771221459 var1072)) ; Statement: $r3 = r2.<org.apache.dubbo.qos.command.impl.SerializeWarnedClasses: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils> 
(assert true)
(define-const var378 var25 (getWarnedClasses/-444103701 var1705)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: java.util.Set getWarnedClasses()>() 
(define-const var3781 var3737 (var2448_stream/-1288525013 (cast-from-var25-to-var2448 var378))) ; Statement: $r5 = interfaceinvoke $r4.<java.util.Set: java.util.stream.Stream stream()>() 
(define-const var1364 var3737 (var3737_sorted/1716554230 var3781)) ; Statement: $r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream sorted()>() 
(define-const var1259 var320 (var3313_joining/-1302177485 (cast-from-String-to-String "\n"))) ; Statement: $r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>("\n") 
(define-const var3791 var2960 (var3737_collect/-2050842585 var1364 var1259)) ; Statement: $r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6) 
(define-const var3365 String (cast-from-var2960-to-String var3791)) ; Statement: $r9 = (java.lang.String) $r8 
(assert true)
(define-const var3171 String (append/672562846 var1738 var3365)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var1738!1 String)
(assert (= var1738!1 (str.++ var1738 var3365)))
(assert true)
(define-const var3903 String (append/672562846 var3171 "\n\n")) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n") 
(declare-const var3171!1 String)
(assert (= var3171!1 (str.++ var3171 "\n\n")))
(assert true)
(define-const var3260 String (toString/-2075883882 var3903)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r13 
(check-sat)
; {isHttp/-1560219278=([org.apache.dubbo.qos.api.CommandContext], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), serializeCheckUtils/-771221459=([org.apache.dubbo.qos.command.impl.SerializeWarnedClasses], org.apache.dubbo.qos.command.util.SerializeCheckUtils), getWarnedClasses/-444103701=([org.apache.dubbo.qos.command.util.SerializeCheckUtils], java.util.Set), var2448_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var25-to-var2448=([java.util.Set], java.util.Collection), var3737_sorted/1716554230=([java.util.stream.Stream], java.util.stream.Stream), var3313_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3737_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var2960-to-String=([java.lang.Object], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3939=org.apache.dubbo.qos.command.impl.SerializeWarnedClasses, var1072=r2, var3340=org.apache.dubbo.qos.api.CommandContext, var1414=r0, var2660=r18, var1179=$z0, var3865=$r1, var1738=$r10, var808=org.apache.dubbo.qos.command.util.SerializeCheckUtils, var1705=$r3, var25=java.util.Set, var378=$r4, var3737=java.util.stream.Stream, var2448=java.util.Collection, var3781=$r5, var1364=$r7, var320=java.util.stream.Collector, var3313=java.util.stream.Collectors, var1259=$r6, var2960=java.lang.Object, var3791=$r8, var3365=$r9, var3171=$r11, var3903=$r12, var3260=$r13}
; {org.apache.dubbo.qos.command.impl.SerializeWarnedClasses=var3939, r2=var1072, org.apache.dubbo.qos.api.CommandContext=var3340, r0=var1414, r18=var2660, $z0=var1179, $r1=var3865, $r10=var1738, org.apache.dubbo.qos.command.util.SerializeCheckUtils=var808, $r3=var1705, java.util.Set=var25, $r4=var378, java.util.stream.Stream=var3737, java.util.Collection=var2448, $r5=var3781, $r7=var1364, java.util.stream.Collector=var320, java.util.stream.Collectors=var3313, $r6=var1259, java.lang.Object=var2960, $r8=var3791, $r9=var3365, $r11=var3171, $r12=var3903, $r13=var3260}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.SerializeWarnedClasses;	r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r18 := @parameter1: java.lang.String[];	$z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>();	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("WarnedClasses: \n");	$r3 = r2.<org.apache.dubbo.qos.command.impl.SerializeWarnedClasses: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: java.util.Set getWarnedClasses()>();	$r5 = interfaceinvoke $r4.<java.util.Set: java.util.stream.Stream stream()>();	$r7 = interfaceinvoke $r5.<java.util.stream.Stream: java.util.stream.Stream sorted()>();	$r6 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>("\n");	$r8 = interfaceinvoke $r7.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r6);	$r9 = (java.lang.String) $r8;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n");	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	return $r13
;block_num 2