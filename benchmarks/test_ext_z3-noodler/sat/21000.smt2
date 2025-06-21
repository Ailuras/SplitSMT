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

(declare-sort var505 0)
(declare-sort var3052 0)
(declare-sort var2836 0)
(declare-sort var224 0)
(declare-sort var1723 0)
(declare-sort var2443 0)
(declare-sort var2226 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-var224-init () (Array Int var224))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun var2443_access$400/94054948 () var1723)
(declare-fun getInterfaceName/-1866749416 (var1723) String)
(declare-fun getMethodName/1851681050 (var3052) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var224 (String) var224)
(declare-fun String_format/1339386452 (String (Array Int var224)) String)
(declare-fun withDescription/65961942 (var2836 String) var2836)
(declare-fun asException/-351536454 (var2836) var2226)
(declare-const null-var505 var505)
(declare-const null-var3052 var3052)
(declare-const var2836-UNIMPLEMENTED var2836)
(declare-const null-__Array__Int__var224__ (Array Int var224))
(declare-const var1619 var505) ; Statement: r15 := @this: io.grpc.health.v1.DubboHealthTriple$HealthImplBase 
(assert (not (= var1619 null-var505)))
(declare-const var125 var3052) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.model.StubMethodDescriptor 
(assert (not (= var125 null-var3052)))
(define-const var1953 var2836 var2836-UNIMPLEMENTED) ; Statement: $r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNIMPLEMENTED> 
(define-const var3983 (Array Int var224) arr-var224-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(define-const var438 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var438)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var438!1 String)
(assert (= var438!1 ""))
(assert true)
(define-const var571 String (append/672562846 var438!1 "/")) ; Statement: $r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var438!2 String)
(assert (= var438!2 (str.++ var438!1 "/")))
(define-const var3243 var1723 var2443_access$400/94054948) ; Statement: $r3 = staticinvoke <io.grpc.health.v1.DubboHealthTriple: org.apache.dubbo.rpc.model.StubServiceDescriptor access$400()>() 
(assert true)
(define-const var1299 String (getInterfaceName/-1866749416 var3243)) ; Statement: $r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.StubServiceDescriptor: java.lang.String getInterfaceName()>() 
(assert true)
(define-const var704 String (append/672562846 var571 var1299)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var571!1 String)
(assert (= var571!1 (str.++ var571 var1299)))
(assert true)
(define-const var2054 String (append/672562846 var704 "/")) ; Statement: $r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/") 
(declare-const var704!1 String)
(assert (= var704!1 (str.++ var704 "/")))
(assert true)
(define-const var1298 String (getMethodName/1851681050 var125)) ; Statement: $r8 = virtualinvoke r7.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String getMethodName()>() 
(assert true)
(define-const var550 String (append/672562846 var2054 var1298)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8) 
(declare-const var2054!1 String)
(assert (= var2054!1 (str.++ var2054 var1298)))
(assert true)
(define-const var3427 String (toString/-2075883882 var550)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var3983!1 (Array Int var224))
(assert (not (= var3983!1 null-__Array__Int__var224__)))
(assert (= (select var3983!1 0) (cast-from-String-to-var224 var3427))) ; Statement: $r0[0] = $r11 
(define-const var3250 String (String_format/1339386452 "Method %s is unimplemented" var3983!1)) ; Statement: $r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Method %s is unimplemented", $r0) 
(assert true)
(define-const var3059 var2836 (withDescription/65961942 var1953 var3250)) ; Statement: $r13 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r12) 
(assert true)
(define-const var533 var2226 (asException/-351536454 var3059)) ; Statement: $r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>() 
 ; Statement: return $r14 
(check-sat)
; {arr-var224-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), var2443_access$400/94054948=([], org.apache.dubbo.rpc.model.StubServiceDescriptor), getInterfaceName/-1866749416=([org.apache.dubbo.rpc.model.StubServiceDescriptor], java.lang.String), getMethodName/1851681050=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var224=([java.lang.String], java.lang.Object), String_format/1339386452=([java.lang.String, java.lang.Object[]], java.lang.String), withDescription/65961942=([org.apache.dubbo.rpc.TriRpcStatus, java.lang.String], org.apache.dubbo.rpc.TriRpcStatus), asException/-351536454=([org.apache.dubbo.rpc.TriRpcStatus], org.apache.dubbo.rpc.StatusRpcException)}
; {var505=io.grpc.health.v1.DubboHealthTriple$HealthImplBase, var1619=r15, var3052=org.apache.dubbo.rpc.model.StubMethodDescriptor, var125=r7, var2836=org.apache.dubbo.rpc.TriRpcStatus, var1953=$r2, var224=java.lang.Object, var3983=$r0, var438=$r1, var571=$r5, var1723=org.apache.dubbo.rpc.model.StubServiceDescriptor, var2443=io.grpc.health.v1.DubboHealthTriple, var3243=$r3, var1299=$r4, var704=$r6, var2054=$r9, var1298=$r8, var550=$r10, var3427=$r11, var3250=$r12, var3059=$r13, var2226=org.apache.dubbo.rpc.StatusRpcException, var533=$r14}
; {io.grpc.health.v1.DubboHealthTriple$HealthImplBase=var505, r15=var1619, org.apache.dubbo.rpc.model.StubMethodDescriptor=var3052, r7=var125, org.apache.dubbo.rpc.TriRpcStatus=var2836, $r2=var1953, java.lang.Object=var224, $r0=var3983, $r1=var438, $r5=var571, org.apache.dubbo.rpc.model.StubServiceDescriptor=var1723, io.grpc.health.v1.DubboHealthTriple=var2443, $r3=var3243, $r4=var1299, $r6=var704, $r9=var2054, $r8=var1298, $r10=var550, $r11=var3427, $r12=var3250, $r13=var3059, org.apache.dubbo.rpc.StatusRpcException=var2226, $r14=var533}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>": 1}
;stmts r15 := @this: io.grpc.health.v1.DubboHealthTriple$HealthImplBase;	r7 := @parameter0: org.apache.dubbo.rpc.model.StubMethodDescriptor;	$r2 = <org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus UNIMPLEMENTED>;	$r0 = newarray (java.lang.Object)[1];	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r5 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r3 = staticinvoke <io.grpc.health.v1.DubboHealthTriple: org.apache.dubbo.rpc.model.StubServiceDescriptor access$400()>();	$r4 = virtualinvoke $r3.<org.apache.dubbo.rpc.model.StubServiceDescriptor: java.lang.String getInterfaceName()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r9 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("/");	$r8 = virtualinvoke r7.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String getMethodName()>();	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r0[0] = $r11;	$r12 = staticinvoke <java.lang.String: java.lang.String format(java.lang.String,java.lang.Object[])>("Method %s is unimplemented", $r0);	$r13 = virtualinvoke $r2.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.TriRpcStatus withDescription(java.lang.String)>($r12);	$r14 = virtualinvoke $r13.<org.apache.dubbo.rpc.TriRpcStatus: org.apache.dubbo.rpc.StatusRpcException asException()>();	return $r14
;block_num 1