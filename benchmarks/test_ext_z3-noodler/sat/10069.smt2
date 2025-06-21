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

(declare-sort var2608 0)
(declare-sort var3903 0)
(declare-sort var875 0)
(declare-sort var3687 0)
(declare-sort var2678 0)
(declare-sort var3950 0)
(declare-sort var3434 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var3687-init () (Array Int var3687))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var3950_access$300/-1697390583 () var2678)
(declare-fun getInterfaceName/-1866749416 (var2678) String)
(declare-fun getMethodName/1851681050 (var3903) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var3687 (String) var3687)
(declare-fun String_format/1339386452 (String (Array Int var3687)) String)
(declare-fun withDescription/65961942 (var875 String) var875)
(declare-fun asException/-351536454 (var875) var3434)
(declare-const null-var2608 var2608)
(declare-const null-var3903 var3903)
(declare-const var875-UNIMPLEMENTED var875)
(declare-const null-__Array__Int__var3687__ (Array Int var3687))
(declare-const var3217 var2608) ; Statement: r15 := @this: org.apache.dubbo.metadata.DubboMetadataServiceV2Triple$MetadataServiceV2ImplBase 
(assert (not (= var3217 null-var2608)))
(declare-const var3908 var3903) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.model.StubMethodDescriptor 
(assert (not (= var3908 null-var3903)))
(define-const var3713 var875 var875-UNIMPLEMENTED) ; Statement: $r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNIMPLEMENTED> 
(define-const var419 (Array Int var3687) arr-var3687-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var2155 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2155)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2155!1 String)
(assert (= var2155!1 ""))
(assert true)
(define-const var214 String (append/672562846 var2155!1 "/")) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var2155!2 String)
(assert (= var2155!2 (str.++ var2155!1 "/")))
(define-const var1813 var2678 var3950_access$300/-1697390583) ; Statement: $r3 = staticinvoke <org.apache.dubbo.metadata.DubboMetadataServiceV2Triple: org.apache.dubbo.rpc.model.StubServiceDescriptor access$300()>() 
(assert true)
(define-const var960 String (getInterfaceName/-1866749416 var1813)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.StubServiceDescriptor: java.lang.String getInterfaceName()>() 
(assert true)
(define-const var3380 String (append/672562846 var214 var960)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var214!1 String)
(assert (= var214!1 (str.++ var214 var960)))
(assert true)
(define-const var2190 String (append/672562846 var3380 "/")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var3380!1 String)
(assert (= var3380!1 (str.++ var3380 "/")))
(assert true)
(define-const var504 String (getMethodName/1851681050 var3908)) ; Statement: $r8 = virtualinvoke r7.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String getMethodName()>() 
(assert true)
(define-const var850 String (append/672562846 var2190 var504)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2190!1 String)
(assert (= var2190!1 (str.++ var2190 var504)))
(assert true)
(define-const var898 String (toString/-2075883882 var850)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var419!1 (Array Int var3687))
(assert (not (= var419!1 null-__Array__Int__var3687__)))
(assert (= (select var419!1 0) (cast-from-String-to-var3687 var898))) ; Statement: $r0[0] = $r11 
(define-const var107 String (String_format/1339386452 "Method %s is unimplemented" var419!1)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Method %s is unimplemented", $r0) 
(assert true)
(define-const var1094 var875 (withDescription/65961942 var3713 var107)) ; Statement: $r13 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r12) 
(assert true)
(define-const var1428 var3434 (asException/-351536454 var1094)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>() 
 ; Statement: return $r14 
(check-sat)
; {arr-var3687-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var3950_access$300/-1697390583=([], org.apache.dubbo.rpc.model.StubServiceDescriptor), getInterfaceName/-1866749416=([org.apache.dubbo.rpc.model.StubServiceDescriptor], java.lang.String), getMethodName/1851681050=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var3687=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), asException/-351536454=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.StatusRpcException)}
; {var2608=org.apache.dubbo.metadata.DubboMetadataServiceV2Triple$MetadataServiceV2ImplBase, var3217=r15, var3903=org.apache.dubbo.rpc.model.StubMethodDescriptor, var3908=r7, var875=org.apache.dubbo.rpc.TriRpcStatus, var3713=$r2, var3687=java.lang.Object, var419=$r0, var2155=$r1, var214=$r5, var2678=org.apache.dubbo.rpc.model.StubServiceDescriptor, var3950=org.apache.dubbo.metadata.DubboMetadataServiceV2Triple, var1813=$r3, var960=$r4, var3380=$r6, var2190=$r9, var504=$r8, var850=$r10, var898=$r11, var107=$r12, var1094=$r13, var3434=org.apache.dubbo.rpc.StatusRpcException, var1428=$r14}
; {org.apache.dubbo.metadata.DubboMetadataServiceV2Triple$MetadataServiceV2ImplBase=var2608, r15=var3217, org.apache.dubbo.rpc.model.StubMethodDescriptor=var3903, r7=var3908, org.apache.dubbo.rpc.TriRpcStatus=var875, $r2=var3713, java.lang.Object=var3687, $r0=var419, $r1=var2155, $r5=var214, org.apache.dubbo.rpc.model.StubServiceDescriptor=var2678, org.apache.dubbo.metadata.DubboMetadataServiceV2Triple=var3950, $r3=var1813, $r4=var960, $r6=var3380, $r9=var2190, $r8=var504, $r10=var850, $r11=var898, $r12=var107, $r13=var1094, org.apache.dubbo.rpc.StatusRpcException=var3434, $r14=var1428}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r15 := @this: org.apache.dubbo.metadata.DubboMetadataServiceV2Triple$MetadataServiceV2ImplBase;	r7 := @parameter0: org.apache.dubbo.rpc.model.StubMethodDescriptor;	$r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNIMPLEMENTED>;	$r0 = newarray (java.lang.Object)[1];	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r3 = staticinvoke <org.apache.dubbo.metadata.DubboMetadataServiceV2Triple: org.apache.dubbo.rpc.model.StubServiceDescriptor access$300()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.StubServiceDescriptor: java.lang.String getInterfaceName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke r7.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String getMethodName()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r0[0] = $r11;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Method %s is unimplemented", $r0);	$r13 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r12);	$r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>();	return $r14
;block_num 1