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

(declare-sort var3599 0)
(declare-sort var1417 0)
(declare-sort var3610 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getMethod/1103248930 (var3599) var1417)
(declare-fun append/-1031950772 (String var3610) String)
(declare-fun cast-from-var1417-to-var3610 (var1417) var3610)
(declare-fun index/-1190524492 (var3599) Int)
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3599 var3599)
(declare-const var1167 var3599) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta 
(assert (not (= var1167 null-var3599)))
(define-const var185 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var185)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var185!1 String)
(assert (= var185!1 ""))
(assert true)
(define-const var2467 String (append/672562846 var185!1 "parameter [")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("parameter [") 
(declare-const var185!2 String)
(assert (= var185!2 (str.++ var185!1 "parameter [")))
(assert true)
(define-const var2927 var1417 (getMethod/1103248930 var1167)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta: java.lang.reflect.Method getMethod()>() 
(assert true)
(define-const var2462 String (append/-1031950772 var2467 (cast-from-var1417-to-var3610 var2927))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var2467!1 String)
(assert (str.prefixof var2467 var2467!1))
(assert true)
(define-const var2017 String (append/672562846 var2462 "] in {")) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] in {") 
(declare-const var2462!1 String)
(assert (= var2462!1 (str.++ var2462 "] in {")))
(define-const var2088 Int (index/-1190524492 var1167)) ; Statement: $i0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta: int index> 
(assert true)
(define-const var3614 String (append/-1001720160 var2017 var2088)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var2017!1 String)
(assert (str.prefixof var2017 var2017!1))
(assert true)
(define-const var2607 String (append/672562846 var3614 "}")) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}") 
(declare-const var3614!1 String)
(assert (= var3614!1 (str.++ var3614 "}")))
(assert true)
(define-const var1805 String (toString/-2075883882 var2607)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getMethod/1103248930=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta], java.lang.reflect.Method), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var1417-to-var3610=([java.lang.reflect.Method], java.lang.Object), index/-1190524492=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta], int), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3599=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta, var1167=r1, var185=$r0, var2467=$r3, var1417=java.lang.reflect.Method, var2927=$r2, var3610=java.lang.Object, var2462=$r4, var2017=$r5, var2088=$i0, var3614=$r6, var2607=$r7, var1805=$r8}
; {org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta=var3599, r1=var1167, $r0=var185, $r3=var2467, java.lang.reflect.Method=var1417, $r2=var2927, java.lang.Object=var3610, $r4=var2462, $r5=var2017, $i0=var2088, $r6=var3614, $r7=var2607, $r8=var1805}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("parameter [");	$r2 = virtualinvoke r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta: java.lang.reflect.Method getMethod()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] in {");	$i0 = r1.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.MethodParameterMeta: int index>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("}");	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	return $r8
;block_num 1