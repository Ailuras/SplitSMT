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

(declare-sort var340 0)
(declare-sort var1874 0)
(declare-sort var929 0)
(declare-sort var2992 0)
(declare-sort var1279 0)
(declare-sort var294 0)
(declare-sort var3955 0)
(declare-sort var3527 0)
(declare-sort var2288 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getMessageRequestCase/-1683094933 (var1874) var2992)
(declare-fun ordinal/-291641772 (var1279) Int)
(declare-fun cast-from-var2992-to-var1279 (var2992) var1279)
(declare-fun this$0/-800129715 (var340) var294)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1031950772 (String var3527) String)
(declare-fun cast-from-var2992-to-var3527 (var2992) var3527)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun val$responseObserver/-800129715 (var340) var2288)
(declare-fun var294_access$500/2120402685 (var294 var1874 var3955 String var2288) void)
(declare-const null-var340 var340)
(declare-const null-var1874 var1874)
(declare-const var929-$SwitchMap$io$grpc$reflection$v1alpha$ServerReflectionRequest$MessageRequestCase (Array Int Int))
(declare-const var3955-UNIMPLEMENTED var3955)
(declare-const var3154 var340) ; Statement: r3 := @this: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1 
(assert (not (= var3154 null-var340)))
(declare-const var2486 var1874) ; Statement: r0 := @parameter0: io.grpc.reflection.v1alpha.ServerReflectionRequest 
(assert (not (= var2486 null-var1874)))
(define-const var1815 (Array Int Int) var929-$SwitchMap$io$grpc$reflection$v1alpha$ServerReflectionRequest$MessageRequestCase) ; Statement: $r1 = <org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$2: int[] $SwitchMap$io$grpc$reflection$v1alpha$ServerReflectionRequest$MessageRequestCase> 
(assert true)
(define-const var1152 var2992 (getMessageRequestCase/-1683094933 var2486)) ; Statement: $r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServerReflectionRequest: io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase getMessageRequestCase()>() 
(assert true)
(define-const var2033 Int (ordinal/-291641772 (cast-from-var2992-to-var1279 var1152))) ; Statement: $i0 = virtualinvoke $r2.<io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase: int ordinal()>() 
(define-const var423 Int (select var1815 var2033)) ; Statement: $i1 = $r1[$i0] 
 ; Statement: tableswitch($i1) {     case 1: goto $r13 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 2: goto $r11 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 3: goto $r9 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 4: goto $r7 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 5: goto $r5 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     default: goto $r15 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>; } 
(assert (and (not (= var423 5)) (and (not (= var423 4)) (and (not (= var423 3)) (and (not (= var423 2)) (and (not (= var423 1)) true)))))) ; Intersect: Negate: Cond: $i1 == 5   and Intersect: Negate: Cond: $i1 == 4   and Intersect: Negate: Cond: $i1 == 3   and Intersect: Negate: Cond: $i1 == 2   and Intersect: Negate: Cond: $i1 == 1   and Non Conditional     
(define-const var852 var294 (this$0/-800129715 var3154)) ; Statement: $r15 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0> 
(define-const var3221 var3955 var3955-UNIMPLEMENTED) ; Statement: $r16 = <org.apache.dubbo.rpc.TriRpcStatus$Code: org.apache.dubbo.rpc.TriRpcStatus$Code UNIMPLEMENTED> 
(define-const var131 String String-init) ; Statement: $r14 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var131)) ; Statement: specialinvoke $r14.<java.lang.StringBuilder: void <init>()>() 
(declare-const var131!1 String)
(assert (= var131!1 ""))
(assert true)
(define-const var3062 String (append/672562846 var131!1 "not implemented ")) ; Statement: $r18 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("not implemented ") 
(declare-const var131!2 String)
(assert (= var131!2 (str.++ var131!1 "not implemented ")))
(assert true)
(define-const var3503 var2992 (getMessageRequestCase/-1683094933 var2486)) ; Statement: $r17 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServerReflectionRequest: io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase getMessageRequestCase()>() 
(assert true)
(define-const var3129 String (append/-1031950772 var3062 (cast-from-var2992-to-var3527 var3503))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17) 
(declare-const var3062!1 String)
(assert (str.prefixof var3062 var3062!1))
(assert true)
(define-const var1495 String (toString/-2075883882 var3129)) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(define-const var2958 var2288 (val$responseObserver/-800129715 var3154)) ; Statement: $r20 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.common.stream.StreamObserver val$responseObserver> 
;(assert (var294_access$500/2120402685 var852 var2486 var3221 var1495 var2958)) ; Statement: staticinvoke <org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService: void access$500(org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService,io.grpc.reflection.v1alpha.ServerReflectionRequest,org.apache.dubbo.rpc.TriRpcStatus$Code,java.lang.String,org.apache.dubbo.common.stream.StreamObserver)>($r15, r0, $r16, $r21, $r20) 

(declare-const var852!1 var294)
(declare-const var2486!1 var1874)
(declare-const var3221!1 var3955)
(declare-const var1495!1 String)
(declare-const var2958!1 var2288)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {getMessageRequestCase/-1683094933=([io.grpc.reflection.v1alpha.ServerReflectionRequest], io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase), ordinal/-291641772=([java.lang.Enum], int), cast-from-var2992-to-var1279=([io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase], java.lang.Enum), this$0/-800129715=([org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1], org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2992-to-var3527=([io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), val$responseObserver/-800129715=([org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1], org.apache.dubbo.common.stream.StreamObserver), var294_access$500/2120402685=([org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService, io.grpc.reflection.v1alpha.ServerReflectionRequest, org.apache.dubbo.rpc.TriRpcStatus$Code, java.lang.String, org.apache.dubbo.common.stream.StreamObserver], void)}
; {var340=org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1, var3154=r3, var1874=io.grpc.reflection.v1alpha.ServerReflectionRequest, var2486=r0, var929=org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$2, var1815=$r1, var2992=io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase, var1152=$r2, var1279=java.lang.Enum, var2033=$i0, var423=$i1, var294=org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService, var852=$r15, var3955=org.apache.dubbo.rpc.TriRpcStatus$Code, var3221=$r16, var131=$r14, var3062=$r18, var3503=$r17, var3527=java.lang.Object, var3129=$r19, var1495=$r21, var2288=org.apache.dubbo.common.stream.StreamObserver, var2958=$r20}
; {org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1=var340, r3=var3154, io.grpc.reflection.v1alpha.ServerReflectionRequest=var1874, r0=var2486, org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$2=var929, $r1=var1815, io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase=var2992, $r2=var1152, java.lang.Enum=var1279, $i0=var2033, $i1=var423, org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService=var294, $r15=var852, org.apache.dubbo.rpc.TriRpcStatus$Code=var3955, $r16=var3221, $r14=var131, $r18=var3062, $r17=var3503, java.lang.Object=var3527, $r19=var3129, $r21=var1495, org.apache.dubbo.common.stream.StreamObserver=var2288, $r20=var2958}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1;	r0 := @parameter0: io.grpc.reflection.v1alpha.ServerReflectionRequest;	$r1 = <org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$2: int[] $SwitchMap$io$grpc$reflection$v1alpha$ServerReflectionRequest$MessageRequestCase>;	$r2 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServerReflectionRequest: io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase getMessageRequestCase()>();	$i0 = virtualinvoke $r2.<io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase: int ordinal()>();	$i1 = $r1[$i0];	tableswitch($i1) {     case 1: goto $r13 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 2: goto $r11 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 3: goto $r9 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 4: goto $r7 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     case 5: goto $r5 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;     default: goto $r15 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>; };	$r15 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService this$0>;	$r16 = <org.apache.dubbo.rpc.TriRpcStatus$Code: org.apache.dubbo.rpc.TriRpcStatus$Code UNIMPLEMENTED>;	$r14 = new java.lang.StringBuilder;	specialinvoke $r14.<java.lang.StringBuilder: void <init>()>();	$r18 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("not implemented ");	$r17 = virtualinvoke r0.<io.grpc.reflection.v1alpha.ServerReflectionRequest: io.grpc.reflection.v1alpha.ServerReflectionRequest$MessageRequestCase getMessageRequestCase()>();	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	$r20 = r3.<org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService$1: org.apache.dubbo.common.stream.StreamObserver val$responseObserver>;	staticinvoke <org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService: void access$500(org.apache.dubbo.rpc.protocol.tri.service.ReflectionV1AlphaService,io.grpc.reflection.v1alpha.ServerReflectionRequest,org.apache.dubbo.rpc.TriRpcStatus$Code,java.lang.String,org.apache.dubbo.common.stream.StreamObserver)>($r15, r0, $r16, $r21, $r20);	return
;block_num 3