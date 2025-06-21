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

(declare-sort var2496 0)
(declare-sort var2802 0)
(declare-sort var2385 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun methodName/822298098 (var2496) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun parameterClasses/822298098 (var2496) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun rpcType/822298098 (var2496) var2802)
(declare-fun append/-1031950772 (String var2385) String)
(declare-fun cast-from-var2802-to-var2385 (var2802) var2385)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2496 var2496)
(declare-const var2325 var2496) ; Statement: r1 := @this: org.apache.dubbo.rpc.model.StubMethodDescriptor 
(assert (not (= var2325 null-var2496)))
(define-const var1779 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1779)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1779!1 String)
(assert (= var1779!1 ""))
(assert true)
(define-const var2838 String (append/672562846 var1779!1 "StubMethodDescriptor{method=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StubMethodDescriptor{method=") 
(declare-const var1779!2 String)
(assert (= var1779!2 (str.++ var1779!1 "StubMethodDescriptor{method=")))
(define-const var2261 String (methodName/822298098 var2325)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var3577 String (append/672562846 var2838 var2261)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var2838!1 String)
(assert (= var2838!1 (str.++ var2838 var2261)))
(assert true)
(define-const var1338 String (append/-1166366385 var3577 40)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var3577!1 String)
(assert (str.prefixof var3577 var3577!1))
(define-const var423 (Array Int ClassObject) (parameterClasses/822298098 var2325)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var396 Int (getLength-Arr-ClassObject-1 var423)) ; Statement: $i0 = lengthof $r5 
 ; Statement: if $i0 <= 0 goto $r15 = "" 
(assert (<= var396 0)) ; Cond: $i0 <= 0 
(define-const var1496 String "") ; Statement: $r15 = "" 
(assert true) ; Non Conditional
(assert true)
(define-const var2815 String (append/672562846 var1338 var1496)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var1338!1 String)
(assert (= var1338!1 (str.++ var1338 var1496)))
(assert true)
(define-const var3427 String (append/672562846 var2815 "), rpcType=\u0027")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), rpcType=\'") 
(declare-const var2815!1 String)
(assert (= var2815!1 (str.++ var2815 "), rpcType=\u0027")))
(define-const var1722 var2802 (rpcType/822298098 var2325)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> 
(assert true)
(define-const var10 String (append/-1031950772 var3427 (cast-from-var2802-to-var2385 var1722))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var3427!1 String)
(assert (str.prefixof var3427 var3427!1))
(assert true)
(define-const var3272 String (append/672562846 var10 "\u0027}")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}") 
(declare-const var10!1 String)
(assert (= var10!1 (str.++ var10 "\u0027}")))
(assert true)
(define-const var1222 String (toString/-2075883882 var3272)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), methodName/822298098=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), parameterClasses/822298098=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), rpcType/822298098=([org.apache.dubbo.rpc.model.StubMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2802-to-var2385=([org.apache.dubbo.rpc.model.MethodDescriptor$RpcType], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2496=org.apache.dubbo.rpc.model.StubMethodDescriptor, var2325=r1, var1779=$r0, var2838=$r3, var2261=$r2, var3577=$r4, var1338=$r6, var423=$r5, var396=$i0, var1496=$r15, var2815=$r7, var3427=$r9, var2802=org.apache.dubbo.rpc.model.MethodDescriptor$RpcType, var1722=$r8, var2385=java.lang.Object, var10=$r10, var3272=$r11, var1222=$r12}
; {org.apache.dubbo.rpc.model.StubMethodDescriptor=var2496, r1=var2325, $r0=var1779, $r3=var2838, $r2=var2261, $r4=var3577, $r6=var1338, $r5=var423, $i0=var396, $r15=var1496, $r7=var2815, $r9=var3427, org.apache.dubbo.rpc.model.MethodDescriptor$RpcType=var2802, $r8=var1722, java.lang.Object=var2385, $r10=var10, $r11=var3272, $r12=var1222}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.model.StubMethodDescriptor;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StubMethodDescriptor{method=");	$r2 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String methodName>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r5 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.Class[] parameterClasses>;	$i0 = lengthof $r5;	if $i0 <= 0 goto $r15 = "";	$r15 = "";	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), rpcType=\'");	$r8 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 3