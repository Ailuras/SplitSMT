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

(declare-sort var2144 0)
(declare-sort var3391 0)
(declare-sort var1408 0)
(declare-sort var332 0)
(declare-sort var279 0)
(declare-sort var3730 0)
(declare-sort var3358 0)
(declare-sort var2389 0)
(declare-sort var3441 0)
(declare-sort var235 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isHttp/-1560219278 (var3391) Bool)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun serializeCheckUtils/-934201466 (var2144) var1408)
(declare-fun getStatus/-1843799848 (var1408) var332)
(declare-fun append/-1031950772 (String var279) String)
(declare-fun cast-from-var332-to-var279 (var332) var279)
(declare-fun isCheckSerializable/-243435391 (var1408) Bool)
(declare-fun append/-388390247 (String Bool) String)
(declare-fun getAllowedList/323258854 (var1408) var3730)
(declare-fun var2389_stream/-1288525013 (var2389) var3358)
(declare-fun cast-from-var3730-to-var2389 (var3730) var2389)
(declare-fun var3358_sorted/1716554230 (var3358) var3358)
(declare-fun var235_joining/-1302177485 (String) var3441)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var3358_collect/-2050842585 (var3358 var3441) var279)
(declare-fun cast-from-var279-to-String (var279) String)
(declare-fun getDisAllowedList/-1919462826 (var1408) var3730)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2144 var2144)
(declare-const null-var3391 var3391)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2668 var2144) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.SerializeCheckStatus 
(assert (not (= var2668 null-var2144)))
(declare-const var2335 var3391) ; Statement: r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var2335 null-var3391)))
(declare-const var313 (Array Int String)) ; Statement: r40 := @parameter1: java.lang.String[] 
(assert (not (= var313 null-__Array__Int__String__)))
(assert true)
(define-const var2178 Bool (isHttp/-1560219278 var2335)) ; Statement: $z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>() 
 ; Statement: if $z0 == 0 goto $r1 = new java.lang.StringBuilder 
(assert (= (ite var2178 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2194 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2194)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2194!1 String)
(assert (= var2194!1 ""))
(assert true)
(define-const var3403 String (append/672562846 var2194!1 "CheckStatus: ")) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("CheckStatus: ") 
(declare-const var2194!2 String)
(assert (= var2194!2 (str.++ var2194!1 "CheckStatus: ")))
(define-const var3394 var1408 (serializeCheckUtils/-934201466 var2668)) ; Statement: $r3 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils> 
(assert true)
(define-const var2611 var332 (getStatus/-1843799848 var3394)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: org.apache.dubbo.common.utils.SerializeCheckStatus getStatus()>() 
(assert true)
(define-const var1731 String (append/-1031950772 var3403 (cast-from-var332-to-var279 var2611))) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4) 
(declare-const var3403!1 String)
(assert (str.prefixof var3403 var3403!1))
(assert true)
(define-const var546 String (append/672562846 var1731 "\n\nCheckSerializable: ")) ; Statement: $r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\nCheckSerializable: ") 
(declare-const var1731!1 String)
(assert (= var1731!1 (str.++ var1731 "\n\nCheckSerializable: ")))
(define-const var1492 var1408 (serializeCheckUtils/-934201466 var2668)) ; Statement: $r7 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils> 
(assert true)
(define-const var3975 Bool (isCheckSerializable/-243435391 var1492)) ; Statement: $z1 = virtualinvoke $r7.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: boolean isCheckSerializable()>() 
(assert true)
(define-const var1188 String (append/-388390247 var546 var3975)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1) 
(declare-const var546!1 String)
(assert (str.prefixof var546 var546!1))
(assert true)
(define-const var2357 String (append/672562846 var1188 "\n\nAllowedPrefix:\n")) ; Statement: $r17 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\nAllowedPrefix:\n") 
(declare-const var1188!1 String)
(assert (= var1188!1 (str.++ var1188 "\n\nAllowedPrefix:\n")))
(define-const var534 var1408 (serializeCheckUtils/-934201466 var2668)) ; Statement: $r10 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils> 
(assert true)
(define-const var2393 var3730 (getAllowedList/323258854 var534)) ; Statement: $r11 = virtualinvoke $r10.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: java.util.Set getAllowedList()>() 
(define-const var322 var3358 (var2389_stream/-1288525013 (cast-from-var3730-to-var2389 var2393))) ; Statement: $r12 = interfaceinvoke $r11.<java.util.Set: java.util.stream.Stream stream()>() 
(define-const var682 var3358 (var3358_sorted/1716554230 var322)) ; Statement: $r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.stream.Stream sorted()>() 
(define-const var1279 var3441 (var235_joining/-1302177485 (cast-from-String-to-String "\n"))) ; Statement: $r13 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>("\n") 
(define-const var1528 var279 (var3358_collect/-2050842585 var682 var1279)) ; Statement: $r15 = interfaceinvoke $r14.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r13) 
(define-const var210 String (cast-from-var279-to-String var1528)) ; Statement: $r16 = (java.lang.String) $r15 
(assert true)
(define-const var2937 String (append/672562846 var2357 var210)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16) 
(declare-const var2357!1 String)
(assert (= var2357!1 (str.++ var2357 var210)))
(assert true)
(define-const var2054 String (append/672562846 var2937 "\n\nDisAllowedPrefix:\n")) ; Statement: $r26 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\nDisAllowedPrefix:\n") 
(declare-const var2937!1 String)
(assert (= var2937!1 (str.++ var2937 "\n\nDisAllowedPrefix:\n")))
(define-const var2579 var1408 (serializeCheckUtils/-934201466 var2668)) ; Statement: $r19 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils> 
(assert true)
(define-const var1212 var3730 (getDisAllowedList/-1919462826 var2579)) ; Statement: $r20 = virtualinvoke $r19.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: java.util.Set getDisAllowedList()>() 
(define-const var3106 var3358 (var2389_stream/-1288525013 (cast-from-var3730-to-var2389 var1212))) ; Statement: $r21 = interfaceinvoke $r20.<java.util.Set: java.util.stream.Stream stream()>() 
(define-const var3904 var3358 (var3358_sorted/1716554230 var3106)) ; Statement: $r23 = interfaceinvoke $r21.<java.util.stream.Stream: java.util.stream.Stream sorted()>() 
(define-const var3795 var3441 (var235_joining/-1302177485 (cast-from-String-to-String "\n"))) ; Statement: $r22 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>("\n") 
(define-const var1860 var279 (var3358_collect/-2050842585 var3904 var3795)) ; Statement: $r24 = interfaceinvoke $r23.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r22) 
(define-const var2411 String (cast-from-var279-to-String var1860)) ; Statement: $r25 = (java.lang.String) $r24 
(assert true)
(define-const var3387 String (append/672562846 var2054 var2411)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25) 
(declare-const var2054!1 String)
(assert (= var2054!1 (str.++ var2054 var2411)))
(assert true)
(define-const var2580 String (append/672562846 var3387 "\n\n")) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n") 
(declare-const var3387!1 String)
(assert (= var3387!1 (str.++ var3387 "\n\n")))
(assert true)
(define-const var2256 String (toString/-2075883882 var2580)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r29 
(check-sat)
; {isHttp/-1560219278=([org.apache.dubbo.qos.api.CommandContext], boolean), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), serializeCheckUtils/-934201466=([org.apache.dubbo.qos.command.impl.SerializeCheckStatus], org.apache.dubbo.qos.command.util.SerializeCheckUtils), getStatus/-1843799848=([org.apache.dubbo.qos.command.util.SerializeCheckUtils], org.apache.dubbo.common.utils.SerializeCheckStatus), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var332-to-var279=([org.apache.dubbo.common.utils.SerializeCheckStatus], java.lang.Object), isCheckSerializable/-243435391=([org.apache.dubbo.qos.command.util.SerializeCheckUtils], boolean), append/-388390247=([java.lang.StringBuilder, boolean], java.lang.StringBuilder), getAllowedList/323258854=([org.apache.dubbo.qos.command.util.SerializeCheckUtils], java.util.Set), var2389_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var3730-to-var2389=([java.util.Set], java.util.Collection), var3358_sorted/1716554230=([java.util.stream.Stream], java.util.stream.Stream), var235_joining/-1302177485=([java.lang.CharSequence], java.util.stream.Collector), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var3358_collect/-2050842585=([java.util.stream.Stream, java.util.stream.Collector], java.lang.Object), cast-from-var279-to-String=([java.lang.Object], java.lang.String), getDisAllowedList/-1919462826=([org.apache.dubbo.qos.command.util.SerializeCheckUtils], java.util.Set), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2144=org.apache.dubbo.qos.command.impl.SerializeCheckStatus, var2668=r2, var3391=org.apache.dubbo.qos.api.CommandContext, var2335=r0, var313=r40, var2178=$z0, var2194=$r1, var3403=$r5, var1408=org.apache.dubbo.qos.command.util.SerializeCheckUtils, var3394=$r3, var332=org.apache.dubbo.common.utils.SerializeCheckStatus, var2611=$r4, var279=java.lang.Object, var1731=$r6, var546=$r8, var1492=$r7, var3975=$z1, var1188=$r9, var2357=$r17, var534=$r10, var3730=java.util.Set, var2393=$r11, var3358=java.util.stream.Stream, var2389=java.util.Collection, var322=$r12, var682=$r14, var3441=java.util.stream.Collector, var235=java.util.stream.Collectors, var1279=$r13, var1528=$r15, var210=$r16, var2937=$r18, var2054=$r26, var2579=$r19, var1212=$r20, var3106=$r21, var3904=$r23, var3795=$r22, var1860=$r24, var2411=$r25, var3387=$r27, var2580=$r28, var2256=$r29}
; {org.apache.dubbo.qos.command.impl.SerializeCheckStatus=var2144, r2=var2668, org.apache.dubbo.qos.api.CommandContext=var3391, r0=var2335, r40=var313, $z0=var2178, $r1=var2194, $r5=var3403, org.apache.dubbo.qos.command.util.SerializeCheckUtils=var1408, $r3=var3394, org.apache.dubbo.common.utils.SerializeCheckStatus=var332, $r4=var2611, java.lang.Object=var279, $r6=var1731, $r8=var546, $r7=var1492, $z1=var3975, $r9=var1188, $r17=var2357, $r10=var534, java.util.Set=var3730, $r11=var2393, java.util.stream.Stream=var3358, java.util.Collection=var2389, $r12=var322, $r14=var682, java.util.stream.Collector=var3441, java.util.stream.Collectors=var235, $r13=var1279, $r15=var1528, $r16=var210, $r18=var2937, $r26=var2054, $r19=var2579, $r20=var1212, $r21=var3106, $r23=var3904, $r22=var3795, $r24=var1860, $r25=var2411, $r27=var3387, $r28=var2580, $r29=var2256}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 7,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.SerializeCheckStatus;	r0 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r40 := @parameter1: java.lang.String[];	$z0 = virtualinvoke r0.<org.apache.dubbo.qos.api.CommandContext: boolean isHttp()>();	if $z0 == 0 goto $r1 = new java.lang.StringBuilder;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("CheckStatus: ");	$r3 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils>;	$r4 = virtualinvoke $r3.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: org.apache.dubbo.common.utils.SerializeCheckStatus getStatus()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r4);	$r8 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\nCheckSerializable: ");	$r7 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils>;	$z1 = virtualinvoke $r7.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: boolean isCheckSerializable()>();	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(boolean)>($z1);	$r17 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\nAllowedPrefix:\n");	$r10 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils>;	$r11 = virtualinvoke $r10.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: java.util.Set getAllowedList()>();	$r12 = interfaceinvoke $r11.<java.util.Set: java.util.stream.Stream stream()>();	$r14 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.stream.Stream sorted()>();	$r13 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>("\n");	$r15 = interfaceinvoke $r14.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r13);	$r16 = (java.lang.String) $r15;	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r16);	$r26 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\nDisAllowedPrefix:\n");	$r19 = r2.<org.apache.dubbo.qos.command.impl.SerializeCheckStatus: org.apache.dubbo.qos.command.util.SerializeCheckUtils serializeCheckUtils>;	$r20 = virtualinvoke $r19.<org.apache.dubbo.qos.command.util.SerializeCheckUtils: java.util.Set getDisAllowedList()>();	$r21 = interfaceinvoke $r20.<java.util.Set: java.util.stream.Stream stream()>();	$r23 = interfaceinvoke $r21.<java.util.stream.Stream: java.util.stream.Stream sorted()>();	$r22 = staticinvoke <java.util.stream.Collectors: java.util.stream.Collector joining(java.lang.CharSequence)>("\n");	$r24 = interfaceinvoke $r23.<java.util.stream.Stream: java.lang.Object collect(java.util.stream.Collector)>($r22);	$r25 = (java.lang.String) $r24;	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r25);	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n\n");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.String toString()>();	return $r29
;block_num 2