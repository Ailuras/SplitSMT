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

(declare-sort var2853 0)
(declare-sort var3866 0)
(declare-sort var3824 0)
(declare-sort var654 0)
(declare-sort var2771 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun method/639256687 (var2853) var3866)
(declare-fun var3824_toShortString/2017261356 (var3866) String)
(declare-fun rpcType/639256687 (var2853) var654)
(declare-fun append/-1031950772 (String var2771) String)
(declare-fun cast-from-var654-to-var2771 (var654) var2771)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2853 var2853)
(declare-const var3778 var2853) ; Statement: r1 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor 
(assert (not (= var3778 null-var2853)))
(define-const var3673 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3673)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3673!1 String)
(assert (= var3673!1 ""))
(assert true)
(define-const var3868 String (append/672562846 var3673!1 "ReflectionMethodDescriptor{method=\u0027")) ; Statement: $r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ReflectionMethodDescriptor{method=\'") 
(declare-const var3673!2 String)
(assert (= var3673!2 (str.++ var3673!1 "ReflectionMethodDescriptor{method=\u0027")))
(define-const var2722 var3866 (method/639256687 var3778)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method> 
(define-const var2175 String (var3824_toShortString/2017261356 var2722)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String toShortString(java.lang.reflect.Method)>($r2) 
(assert true)
(define-const var3867 String (append/672562846 var3868 var2175)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var3868!1 String)
(assert (= var3868!1 (str.++ var3868 var2175)))
(assert true)
(define-const var875 String (append/672562846 var3867 "\u0027, rpcType=")) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\', rpcType=") 
(declare-const var3867!1 String)
(assert (= var3867!1 (str.++ var3867 "\u0027, rpcType=")))
(define-const var156 var654 (rpcType/639256687 var3778)) ; Statement: $r6 = r1.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType> 
(assert true)
(define-const var407 String (append/-1031950772 var875 (cast-from-var654-to-var2771 var156))) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6) 
(declare-const var875!1 String)
(assert (str.prefixof var875 var875!1))
(assert true)
(define-const var183 String (append/-1166366385 var407 125)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var407!1 String)
(assert (str.prefixof var407 var407!1))
(assert true)
(define-const var1850 String (toString/-2075883882 var183)) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r10 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), method/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], java.lang.reflect.Method), var3824_toShortString/2017261356=([java.lang.reflect.Method], java.lang.String), rpcType/639256687=([org.apache.dubbo.rpc.model.ReflectionMethodDescriptor], org.apache.dubbo.rpc.model.MethodDescriptor$RpcType), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var654-to-var2771=([org.apache.dubbo.rpc.model.MethodDescriptor$RpcType], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2853=org.apache.dubbo.rpc.model.ReflectionMethodDescriptor, var3778=r1, var3673=$r0, var3868=$r4, var3866=java.lang.reflect.Method, var2722=$r2, var3824=org.apache.dubbo.common.utils.MethodUtils, var2175=$r3, var3867=$r5, var875=$r7, var654=org.apache.dubbo.rpc.model.MethodDescriptor$RpcType, var156=$r6, var2771=java.lang.Object, var407=$r8, var183=$r9, var1850=$r10}
; {org.apache.dubbo.rpc.model.ReflectionMethodDescriptor=var2853, r1=var3778, $r0=var3673, $r4=var3868, java.lang.reflect.Method=var3866, $r2=var2722, org.apache.dubbo.common.utils.MethodUtils=var3824, $r3=var2175, $r5=var3867, $r7=var875, org.apache.dubbo.rpc.model.MethodDescriptor$RpcType=var654, $r6=var156, java.lang.Object=var2771, $r8=var407, $r9=var183, $r10=var1850}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.model.ReflectionMethodDescriptor;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ReflectionMethodDescriptor{method=\'");	$r2 = r1.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: java.lang.reflect.Method method>;	$r3 = staticinvoke <org.apache.dubbo.common.utils.MethodUtils: java.lang.String toShortString(java.lang.reflect.Method)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\', rpcType=");	$r6 = r1.<org.apache.dubbo.rpc.model.ReflectionMethodDescriptor: org.apache.dubbo.rpc.model.MethodDescriptor$RpcType rpcType>;	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r6);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.String toString()>();	return $r10
;block_num 1