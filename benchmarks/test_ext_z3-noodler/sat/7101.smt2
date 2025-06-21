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

(declare-sort var465 0)
(declare-sort var1616 0)
(declare-sort var645 0)
(declare-sort var1548 0)
(declare-sort var2018 0)
(declare-sort var1153 0)
(declare-sort var1869 0)
(declare-sort var2943 0)
(declare-sort var2115 0)
(declare-sort var3871 0)
(declare-sort var1670 0)
(declare-sort var1629 0)
(declare-sort var972 0)
(declare-sort var1971 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun descToMethods/-1801301339 (var465) var1548)
(declare-fun var1153_bootstrap$/-899363462 () var2018)
(declare-fun var1548_computeIfAbsent/2133881068 (var1548 var1869 var2018) var1869)
(declare-fun cast-from-String-to-var1869 (String) var1869)
(declare-fun cast-from-var1869-to-var1548 (var1869) var1548)
(declare-fun var2115_stream/-1288525013 (var2115) var2943)
(declare-fun cast-from-var645-to-var2115 (var645) var2115)
(declare-fun var1670_bootstrap$/538657393 (var1548) var3871)
(declare-fun var2943_peek/-1564289730 (var2943 var3871) var2943)
(declare-fun var1629_bootstrap$/-2003380825 () var2018)
(declare-fun var2943_map/130902797 (var2943 var2018) var2943)
(declare-fun var1971_bootstrap$/980705979 () var972)
(declare-fun var2943_filter/320182972 (var2943 var972) var2943)
(declare-fun var2943_count/1394145530 (var2943) Int)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var465 var465)
(declare-const null-String String)
(declare-const null-var645 var645)
(declare-const var3286 var465) ; Statement: r0 := @this: org.apache.dubbo.rpc.model.ReflectionServiceDescriptor 
(assert (not (= var3286 null-var465)))
(declare-const var213 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var213 null-String)))
(declare-const var3984 var645) ; Statement: r6 := @parameter1: java.util.List 
(assert (not (= var3984 null-var645)))
(define-const var1253 var1548 (descToMethods/-1801301339 var3286)) ; Statement: $r2 = r0.<org.apache.dubbo.rpc.model.ReflectionServiceDescriptor: java.util.Map descToMethods> 
(define-const var771 var2018 var1153_bootstrap$/-899363462) ; Statement: $r3 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435: java.util.function.Function bootstrap$()>() 
(define-const var3879 var1869 (var1548_computeIfAbsent/2133881068 var1253 (cast-from-String-to-var1869 var213) var771)) ; Statement: $r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r1, $r3) 
(define-const var1330 var1548 (cast-from-var1869-to-var1548 var3879)) ; Statement: r5 = (java.util.Map) $r4 
(define-const var1475 var2943 (var2115_stream/-1288525013 (cast-from-var645-to-var2115 var3984))) ; Statement: $r8 = interfaceinvoke r6.<java.util.List: java.util.stream.Stream stream()>() 
(define-const var1967 var3871 (var1670_bootstrap$/538657393 var1330)) ; Statement: $r7 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439: java.util.function.Consumer bootstrap$(java.util.Map)>(r5) 
(define-const var2203 var2943 (var2943_peek/-1564289730 var1475 var1967)) ; Statement: $r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream peek(java.util.function.Consumer)>($r7) 
(define-const var3560 var2018 var1629_bootstrap$/-2003380825) ; Statement: $r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444: java.util.function.Function bootstrap$()>() 
(define-const var175 var2943 (var2943_map/130902797 var2203 var3560)) ; Statement: $r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9) 
(define-const var1092 var972 var1971_bootstrap$/980705979) ; Statement: $r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451: java.util.function.Predicate bootstrap$()>() 
(define-const var585 var2943 (var2943_filter/320182972 var175 var1092)) ; Statement: $r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r11) 
(define-const var837 Int (var2943_count/1394145530 var585)) ; Statement: l0 = interfaceinvoke $r13.<java.util.stream.Stream: long count()>() 
(define-const var3886 Int (ite (> var837 1) 1 (ite (< var837 1) -1 0))) ; Statement: $b1 = l0 cmp 1L 
(define-const var116 Int (cast-from-Int-to-Int var3886)) ; Statement: $i2 = (int) $b1 
 ; Statement: if $i2 <= 0 goto return 
(assert (<= var116 0)) ; Cond: $i2 <= 0 
 ; Statement: return 
(check-sat)
; {descToMethods/-1801301339=([org.apache.dubbo.rpc.model.ReflectionServiceDescriptor], java.util.Map), var1153_bootstrap$/-899363462=([], java.util.function.Function), var1548_computeIfAbsent/2133881068=([java.util.Map, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var1869=([java.lang.String], java.lang.Object), cast-from-var1869-to-var1548=([java.lang.Object], java.util.Map), var2115_stream/-1288525013=([java.util.Collection], java.util.stream.Stream), cast-from-var645-to-var2115=([java.util.List], java.util.Collection), var1670_bootstrap$/538657393=([java.util.Map], java.util.function.Consumer), var2943_peek/-1564289730=([java.util.stream.Stream, java.util.function.Consumer], java.util.stream.Stream), var1629_bootstrap$/-2003380825=([], java.util.function.Function), var2943_map/130902797=([java.util.stream.Stream, java.util.function.Function], java.util.stream.Stream), var1971_bootstrap$/980705979=([], java.util.function.Predicate), var2943_filter/320182972=([java.util.stream.Stream, java.util.function.Predicate], java.util.stream.Stream), var2943_count/1394145530=([java.util.stream.Stream], long), cast-from-Int-to-Int=([byte], int)}
; {var465=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor, var3286=r0, var213=r1, var1616=null_type, var645=java.util.List, var3984=r6, var1548=java.util.Map, var1253=$r2, var2018=java.util.function.Function, var1153=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435, var771=$r3, var1869=java.lang.Object, var3879=$r4, var1330=r5, var2943=java.util.stream.Stream, var2115=java.util.Collection, var1475=$r8, var3871=java.util.function.Consumer, var1670=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439, var1967=$r7, var2203=$r10, var1629=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444, var3560=$r9, var175=$r12, var972=java.util.function.Predicate, var1971=org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451, var1092=$r11, var585=$r13, var837=l0, var3886=$b1, var116=$i2}
; {org.apache.dubbo.rpc.model.ReflectionServiceDescriptor=var465, r0=var3286, r1=var213, null_type=var1616, java.util.List=var645, r6=var3984, java.util.Map=var1548, $r2=var1253, java.util.function.Function=var2018, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435=var1153, $r3=var771, java.lang.Object=var1869, $r4=var3879, r5=var1330, java.util.stream.Stream=var2943, java.util.Collection=var2115, $r8=var1475, java.util.function.Consumer=var3871, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439=var1670, $r7=var1967, $r10=var2203, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444=var1629, $r9=var3560, $r12=var175, java.util.function.Predicate=var972, org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451=var1971, $r11=var1092, $r13=var585, l0=var837, $b1=var3886, $i2=var116}
;seq 
;cnt {}
;stmts r0 := @this: org.apache.dubbo.rpc.model.ReflectionServiceDescriptor;	r1 := @parameter0: java.lang.String;	r6 := @parameter1: java.util.List;	$r2 = r0.<org.apache.dubbo.rpc.model.ReflectionServiceDescriptor: java.util.Map descToMethods>;	$r3 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_3__435: java.util.function.Function bootstrap$()>();	$r4 = interfaceinvoke $r2.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r1, $r3);	r5 = (java.util.Map) $r4;	$r8 = interfaceinvoke r6.<java.util.List: java.util.stream.Stream stream()>();	$r7 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_4__439: java.util.function.Consumer bootstrap$(java.util.Map)>(r5);	$r10 = interfaceinvoke $r8.<java.util.stream.Stream: java.util.stream.Stream peek(java.util.function.Consumer)>($r7);	$r9 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$getRpcType__444: java.util.function.Function bootstrap$()>();	$r12 = interfaceinvoke $r10.<java.util.stream.Stream: java.util.stream.Stream map(java.util.function.Function)>($r9);	$r11 = staticinvoke <org.apache.dubbo.rpc.model.ReflectionServiceDescriptor$lambda_initMethods_5__451: java.util.function.Predicate bootstrap$()>();	$r13 = interfaceinvoke $r12.<java.util.stream.Stream: java.util.stream.Stream filter(java.util.function.Predicate)>($r11);	l0 = interfaceinvoke $r13.<java.util.stream.Stream: long count()>();	$b1 = l0 cmp 1L;	$i2 = (int) $b1;	if $i2 <= 0 goto return;	return
;block_num 2