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

(declare-sort var24 0)
(declare-sort var2958 0)
(declare-sort var4 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun methodName/822298098 (var24) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun parameterClasses/822298098 (var24) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun getSimpleName/-390194377 (ClassObject) String)
(declare-fun rpcType/822298098 (var24) var2958)
(declare-fun append/-1031950772 (String var4) String)
(declare-fun cast-from-var2958-to-var4 (var2958) var4)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var24 var24)
(declare-const var2657 var24) ; Statement: r1 := @this: org.apache.dubbo.rpc.model.StubMethodDescriptor 
(assert (not (= var2657 null-var24)))
(define-const var1203 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1203)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1203!1 String)
(assert (= var1203!1 ""))
(assert true)
(define-const var3548 String (append/672562846 var1203!1 "StubMethodDescriptor{method=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StubMethodDescriptor{method=") 
(declare-const var1203!2 String)
(assert (= var1203!2 (str.++ var1203!1 "StubMethodDescriptor{method=")))
(define-const var3823 String (methodName/822298098 var2657)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String methodName> 
(assert true)
(define-const var3892 String (append/672562846 var3548 var3823)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3548!1 String)
(assert (= var3548!1 (str.++ var3548 var3823)))
(assert true)
(define-const var3690 String (append/-1166366385 var3892 40)) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var3892!1 String)
(assert (str.prefixof var3892 var3892!1))
(define-const var331 (Array Int ClassObject) (parameterClasses/822298098 var2657)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var1947 Int (getLength-Arr-ClassObject-1 var331)) ; Statement: $i0 = lengthof $r5 
 ; Statement: if $i0 <= 0 goto $r15 = "" 
(assert (not (<= var1947 0))) ; Negate: Cond: $i0 <= 0  
(define-const var802 (Array Int ClassObject) (parameterClasses/822298098 var2657)) ; Statement: $r13 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.Class[] parameterClasses> 
(define-const var1370 ClassObject (select var802 0)) ; Statement: $r14 = $r13[0] 
(assert true)
(define-const var1686 String (getSimpleName/-390194377 var1370)) ; Statement: $r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getSimpleName()>() 
 ; Statement: goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15)] 
(assert true) ; Non Conditional
(assert true)
(define-const var3769 String (append/672562846 var3690 var1686)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var3690!1 String)
(assert (= var3690!1 (str.++ var3690 var1686)))
(assert true)
(define-const var591 String (append/672562846 var3769 "), rpcType=\u0027")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), rpcType=\'") 
(declare-const var3769!1 String)
(assert (= var3769!1 (str.++ var3769 "), rpcType=\u0027")))
(define-const var1581 var2958 (rpcType/822298098 var2657)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> 
(assert true)
(define-const var3867 String (append/-1031950772 var591 (cast-from-var2958-to-var4 var1581))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var591!1 String)
(assert (str.prefixof var591 var591!1))
(assert true)
(define-const var2834 String (append/672562846 var3867 "\u0027}")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}") 
(declare-const var3867!1 String)
(assert (= var3867!1 (str.++ var3867 "\u0027}")))
(assert true)
(define-const var2800 String (toString/-2075883882 var2834)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r12 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), methodName/822298098=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.String), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), parameterClasses/822298098=([org.apache.dubbo.rpc.model.StubMethodDescriptor], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), getSimpleName/-390194377=([java.lang.Class], java.lang.String), rpcType/822298098=([org.apache.dubbo.rpc.model.StubMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2958-to-var4=([org.apache.dubbo.rpc.model.MethodDescriptor$RpcType], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var24=org.apache.dubbo.rpc.model.StubMethodDescriptor, var2657=r1, var1203=$r0, var3548=$r3, var3823=$r2, var3892=$r4, var3690=$r6, var331=$r5, var1947=$i0, var802=$r13, var1370=$r14, var1686=$r15, var3769=$r7, var591=$r9, var2958=org.apache.dubbo.rpc.model.MethodDescriptor$RpcType, var1581=$r8, var4=java.lang.Object, var3867=$r10, var2834=$r11, var2800=$r12}
; {org.apache.dubbo.rpc.model.StubMethodDescriptor=var24, r1=var2657, $r0=var1203, $r3=var3548, $r2=var3823, $r4=var3892, $r6=var3690, $r5=var331, $i0=var1947, $r13=var802, $r14=var1370, $r15=var1686, $r7=var3769, $r9=var591, org.apache.dubbo.rpc.model.MethodDescriptor$RpcType=var2958, $r8=var1581, java.lang.Object=var4, $r10=var3867, $r11=var2834, $r12=var2800}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.model.StubMethodDescriptor;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("StubMethodDescriptor{method=");	$r2 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.String methodName>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r5 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.Class[] parameterClasses>;	$i0 = lengthof $r5;	if $i0 <= 0 goto $r15 = "";	$r13 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: java.lang.Class[] parameterClasses>;	$r14 = $r13[0];	$r15 = virtualinvoke $r14.<java.lang.Class: java.lang.String getSimpleName()>();	goto [?= $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15)];	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("), rpcType=\'");	$r8 = r1.<org.apache.dubbo.rpc.model.StubMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\'}");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	return $r12
;block_num 3