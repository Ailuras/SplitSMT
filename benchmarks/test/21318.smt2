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

(declare-sort var1720 0)
(declare-sort var2840 0)
(declare-sort var3780 0)
(declare-sort var1325 0)
(declare-sort var3154 0)
(declare-sort var2615 0)
(declare-sort var814 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var1325-init () (Array Int var1325))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2615_access$100/-433839820 () var3154)
(declare-fun getInterfaceName/-1866749416 (var3154) String)
(declare-fun getMethodName/1851681050 (var2840) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var1325 (String) var1325)
(declare-fun String_format/1339386452 (String (Array Int var1325)) String)
(declare-fun withDescription/65961942 (var3780 String) var3780)
(declare-fun asException/-351536454 (var3780) var814)
(declare-const null-var1720 var1720)
(declare-const null-var2840 var2840)
(declare-const var3780-UNIMPLEMENTED var3780)
(declare-const null-__Array__Int__var1325__ (Array Int var1325))
(declare-const var2230 var1720) ; Statement: r15 := @this: io.grpc.reflection.v1alpha.DubboServerReflectionTriple$ServerReflectionImplBase 
(assert (not (= var2230 null-var1720)))
(declare-const var1451 var2840) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.model.StubMethodDescriptor 
(assert (not (= var1451 null-var2840)))
(define-const var1873 var3780 var3780-UNIMPLEMENTED) ; Statement: $r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNIMPLEMENTED> 
(define-const var824 (Array Int var1325) arr-var1325-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var3017 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3017)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3017!1 String)
(assert (= var3017!1 ""))
(assert true)
(define-const var1545 String (append/672562846 var3017!1 "/")) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3017!2 String)
(assert (= var3017!2 (str.++ var3017!1 "/")))
(define-const var3188 var3154 var2615_access$100/-433839820) ; Statement: $r3 = staticinvoke <io.grpc.reflection.v1alpha.DubboServerReflectionTriple: org.apache.dubbo.rpc.model.StubServiceDescriptor access$100()>() 
(assert true)
(define-const var2894 String (getInterfaceName/-1866749416 var3188)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.StubServiceDescriptor: java.lang.String getInterfaceName()>() 
(assert true)
(define-const var3301 String (append/672562846 var1545 var2894)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var1545!1 String)
(assert (= var1545!1 (str.++ var1545 var2894)))
(assert true)
(define-const var1625 String (append/672562846 var3301 "/")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3301!1 String)
(assert (= var3301!1 (str.++ var3301 "/")))
(assert true)
(define-const var2726 String (getMethodName/1851681050 var1451)) ; Statement: $r8 = virtualinvoke r7.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String getMethodName()>() 
(assert true)
(define-const var2768 String (append/672562846 var1625 var2726)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var1625!1 String)
(assert (= var1625!1 (str.++ var1625 var2726)))
(assert true)
(define-const var2914 String (toString/-2075883882 var2768)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var824!1 (Array Int var1325))
(assert (not (= var824!1 null-__Array__Int__var1325__)))
(assert (= (select var824!1 0) (cast-from-String-to-var1325 var2914))) ; Statement: $r0[0] = $r11 
(define-const var965 String (String_format/1339386452 "Method %s is unimplemented" var824!1)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Method %s is unimplemented", $r0) 
(assert true)
(define-const var1649 var3780 (withDescription/65961942 var1873 var965)) ; Statement: $r13 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r12) 
(assert true)
(define-const var2268 var814 (asException/-351536454 var1649)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>() 
 ; Statement: return $r14 
(check-sat)
; {arr-var1325-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2615_access$100/-433839820=([], org.apache.dubbo.rpc.model.StubServiceDescriptor), getInterfaceName/-1866749416=([org.apache.dubbo.rpc.model.StubServiceDescriptor], java.lang.String), getMethodName/1851681050=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var1325=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), asException/-351536454=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.StatusRpcException)}
; {var1720=io.grpc.reflection.v1alpha.DubboServerReflectionTriple$ServerReflectionImplBase, var2230=r15, var2840=org.apache.dubbo.rpc.model.StubMethodDescriptor, var1451=r7, var3780=org.apache.dubbo.rpc.TriRpcStatus, var1873=$r2, var1325=java.lang.Object, var824=$r0, var3017=$r1, var1545=$r5, var3154=org.apache.dubbo.rpc.model.StubServiceDescriptor, var2615=io.grpc.reflection.v1alpha.DubboServerReflectionTriple, var3188=$r3, var2894=$r4, var3301=$r6, var1625=$r9, var2726=$r8, var2768=$r10, var2914=$r11, var965=$r12, var1649=$r13, var814=org.apache.dubbo.rpc.StatusRpcException, var2268=$r14}
; {io.grpc.reflection.v1alpha.DubboServerReflectionTriple$ServerReflectionImplBase=var1720, r15=var2230, org.apache.dubbo.rpc.model.StubMethodDescriptor=var2840, r7=var1451, org.apache.dubbo.rpc.TriRpcStatus=var3780, $r2=var1873, java.lang.Object=var1325, $r0=var824, $r1=var3017, $r5=var1545, org.apache.dubbo.rpc.model.StubServiceDescriptor=var3154, io.grpc.reflection.v1alpha.DubboServerReflectionTriple=var2615, $r3=var3188, $r4=var2894, $r6=var3301, $r9=var1625, $r8=var2726, $r10=var2768, $r11=var2914, $r12=var965, $r13=var1649, org.apache.dubbo.rpc.StatusRpcException=var814, $r14=var2268}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r15 := @this: io.grpc.reflection.v1alpha.DubboServerReflectionTriple$ServerReflectionImplBase;	r7 := @parameter0: org.apache.dubbo.rpc.model.StubMethodDescriptor;	$r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNIMPLEMENTED>;	$r0 = newarray (java.lang.Object)[1];	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r3 = staticinvoke <io.grpc.reflection.v1alpha.DubboServerReflectionTriple: org.apache.dubbo.rpc.model.StubServiceDescriptor access$100()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.StubServiceDescriptor: java.lang.String getInterfaceName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke r7.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String getMethodName()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r0[0] = $r11;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Method %s is unimplemented", $r0);	$r13 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r12);	$r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>();	return $r14
;block_num 1