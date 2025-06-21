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

(declare-sort var265 0)
(declare-sort var3661 0)
(declare-sort var1020 0)
(declare-sort var3250 0)
(declare-sort var2677 0)
(declare-sort var396 0)
(declare-sort var991 0)
(declare-sort var2693 0)
(declare-sort var753 0)
(declare-sort var2296 0)
(declare-sort var1398 0)
(declare-sort var1782 0)
(declare-sort var1795 0)
(declare-sort var1208 0)
(declare-sort var447 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun descToMethods/-1801301339 (var265) var3250)
(declare-fun var396_bootstrap$/-899363462 () var2677)
(declare-fun var3250_computeIfAbsent/2133881068 (var3250 var991 var2677) var991)
(declare-fun cast-from-String-to-var991 (String) var991)
(declare-fun cast-from-var991-to-var3250 (var991) var3250)
(declare-fun var753_stream/-1288525013 (var753) var2693)
(declare-fun cast-from-var1020-to-var753 (var1020) var753)
(declare-fun var1398_bootstrap$/538657393 (var3250) var2296)
(declare-fun var2693_peek/-1564289730 (var2693 var2296) var2693)
(declare-fun var1782_bootstrap$/-2003380825 () var2677)
(declare-fun var2693_map/130902797 (var2693 var2677) var2693)
(declare-fun var1208_bootstrap$/980705979 () var1795)
(declare-fun var2693_filter/320182972 (var2693 var1795) var2693)
(declare-fun var2693_count/1394145530 (var2693) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var447-init () var447)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-901862667 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var447 String) void)
(declare-const null-var265 var265)
(declare-const null-String String)
(declare-const null-var1020 var1020)
(declare-const var782 var265) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ReflectionServiceDescriptor 
(assert (not (= var782 null-var265)))
(declare-const var692 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var692 null-String)))
(declare-const var2052 var1020) ; Statement: r6 := @parameter1: java.util.List 
(assert (not (= var2052 null-var1020)))
(define-const var605 var3250 (descToMethods/-1801301339 var782)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.model.ReflectionServiceDescriptor: java.util.Map descToMethods> 
(define-const var3562 var2677 var396_bootstrap$/-899363462) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435: java.util.function.Function bootstrap$()>() 
(define-const var2962 var991 (var3250_computeIfAbsent/2133881068 var605 (cast-from-String-to-var991 var692) var3562)) ; Statement: $r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r1, $r3) 
(define-const var1488 var3250 (cast-from-var991-to-var3250 var2962)) ; Statement: r5 = (java.util.Map) $r4 
(define-const var3484 var2693 (var753_stream/-1288525013 (cast-from-var1020-to-var753 var2052))) ; Statement: $r8 = interfaceinvoke r6.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var3063 var2296 (var1398_bootstrap$/538657393 var1488)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439: java.util.function.Consumer bootstrap$(java.util.Map)>(r5) 
(define-const var2593 var2693 (var2693_peek/-1564289730 var3484 var3063)) ; Statement: $r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream peek(java.util.function.Consumer)>($r7) 
(define-const var2417 var2677 var1782_bootstrap$/-2003380825) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444: java.util.function.Function bootstrap$()>() 
(define-const var3768 var2693 (var2693_map/130902797 var2593 var2417)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var918 var1795 var1208_bootstrap$/980705979) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451: java.util.function.Predicate bootstrap$()>() 
(define-const var1547 var2693 (var2693_filter/320182972 var3768 var918)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r11) 
(define-const var1680 Int (var2693_count/1394145530 var1547)) ; Statement: l0 = interfaceinvoke $r13.<java.util.stream.Stream: long count()>() 
(define-const var3618 Int (ite (> var1680 1) 1 (ite (< var1680 1) -1 0))) ; Statement: $b1 = l0 cmp 1L 
(define-const var322 Int (cast-from-Int-to-Int var3618)) ; Statement: $i2 = (int) $b1 
 ; Statement: if $i2 <= 0 goto return 
(assert (not (<= var322 0))) ; Negate: Cond: $i2 <= 0  
(define-const var1605 var447 var447-init) ; Statement: $r23 = new java.lang.IllegalStateException 
(define-const var3285 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3285)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3285!1 String)
(assert (= var3285!1 ""))
(assert true)
(define-const var3457 String (append/672562846 var3285!1 "Stream method could not be overloaded.There are ")) ; Statement: $r16 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Stream method could not be overloaded.There are ") 
(declare-const var3285!2 String)
(assert (= var3285!2 (str.++ var3285!1 "Stream method could not be overloaded.There are ")))
(assert true)
(define-const var2869 String (append/-901862667 var3457 var1680)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0) 
(declare-const var3457!1 String)
(assert (str.prefixof var3457 var3457!1))
(assert true)
(define-const var929 String (append/672562846 var2869 " stream method signatures. method(")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" stream method signatures. method(") 
(declare-const var2869!1 String)
(assert (= var2869!1 (str.++ var2869 " stream method signatures. method(")))
(assert true)
(define-const var170 String (append/672562846 var929 var692)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var929!1 String)
(assert (= var929!1 (str.++ var929 var692)))
(assert true)
(define-const var1467 String (append/672562846 var170 ")")) ; Statement: $r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")") 
(declare-const var170!1 String)
(assert (= var170!1 (str.++ var170 ")")))
(assert true)
(define-const var2507 String (toString/-2075883882 var1467)) ; Statement: $r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var1605 var2507)) ; Statement: specialinvoke $r23.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r21) 

(declare-const var1605!1 var447)
(declare-const var2507!1 String)
 ; Statement: throw $r23 
(check-sat)
; {descToMethods/-1801301339=([org.apache.dubbo.rpc.model.ReflectionServiceDescriptor], java.util.Map), var396_bootstrap$/-899363462=([], java.util.function.Function), var3250_computeIfAbsent/2133881068=([java.util.Map, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var991=([java.lang.String], java.lang.Object), cast-from-var991-to-var3250=([java.lang.Object], java.util.Map), var753_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var1020-to-var753=([java.util.List], java.util.Collection), var1398_bootstrap$/538657393=([java.util.Map], java.util.function.Consumer), var2693_peek/-1564289730=([java.util.stream.Stream, java.util.function.Consumer], java.util.stream.Stream), var1782_bootstrap$/-2003380825=([], java.util.function.Function), var2693_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1208_bootstrap$/980705979=([], java.util.function.Predicate), var2693_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var2693_count/1394145530=([java.util.stream.Stream], long), cast-from-Int-to-Int=([byte], int), var447-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-901862667=([java.lang.StringBuilder, long], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var265=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor, var782=r0, var692=r1, var3661=null_type, var1020=java.util.List, var2052=r6, var3250=java.util.Map, var605=$r2, var2677=java.util.function.Function, var396=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435, var3562=$r3, var991=java.lang.Object, var2962=$r4, var1488=r5, var2693=java.util.stream.Stream, var753=java.util.Collection, var3484=$r8, var2296=java.util.function.Consumer, var1398=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439, var3063=$r7, var2593=$r10, var1782=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444, var2417=$r9, var3768=$r12, var1795=java.util.function.Predicate, var1208=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451, var918=$r11, var1547=$r13, var1680=l0, var3618=$b1, var322=$i2, var447=java.lang.IllegalStateException, var1605=$r23, var3285=$r22, var3457=$r16, var2869=$r17, var929=$r18, var170=$r19, var1467=$r20, var2507=$r21}
; {org.apache.dubbo.rpc.model.ReflectionServiceDescriptor=var265, r0=var782, r1=var692, null_type=var3661, java.util.List=var1020, r6=var2052, java.util.Map=var3250, $r2=var605, java.util.function.Function=var2677, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435=var396, $r3=var3562, java.lang.Object=var991, $r4=var2962, r5=var1488, java.util.stream.Stream=var2693, java.util.Collection=var753, $r8=var3484, java.util.function.Consumer=var2296, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439=var1398, $r7=var3063, $r10=var2593, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444=var1782, $r9=var2417, $r12=var3768, java.util.function.Predicate=var1795, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451=var1208, $r11=var918, $r13=var1547, l0=var1680, $b1=var3618, $i2=var322, java.lang.IllegalStateException=var447, $r23=var1605, $r22=var3285, $r16=var3457, $r17=var2869, $r18=var929, $r19=var170, $r20=var1467, $r21=var2507}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(long)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(long)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ReflectionServiceDescriptor;	r1 := @parameter0: java.lang.String;	r6 := @parameter1: java.util.List;	$r2 = r0.<org.apache.dubbo.rpc.model.ReflectionServiceDescriptor: java.util.Map descToMethods>;	$r3 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435: java.util.function.Function bootstrap$()>();	$r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r1, $r3);	r5 = (java.util.Map) $r4;	$r8 = interfaceinvoke r6.<java.util.List: java.util.stream.Stream stream()>();	$r7 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439: java.util.function.Consumer bootstrap$(java.util.Map)>(r5);	$r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream peek(java.util.function.Consumer)>($r7);	$r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451: java.util.function.Predicate bootstrap$()>();	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r11);	l0 = interfaceinvoke $r13.<java.util.stream.Stream: long count()>();	$b1 = l0 cmp 1L;	$i2 = (int) $b1;	if $i2 <= 0 goto return;	$r23 = new java.lang.IllegalStateException;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r16 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Stream method could not be overloaded.There are ");	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(long)>(l0);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" stream method signatures. method(");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r20 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(")");	$r21 = virtualinvoke $r20.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r23.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r21);	throw $r23
;block_num 2