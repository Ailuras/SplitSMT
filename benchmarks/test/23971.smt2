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

(declare-sort var1600 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun path/953008138 (var1600) String)
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun append/-1166366385 (String Int) String)
(declare-fun methodName/953008138 (var1600) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1600 var1600)
(declare-const var2586 var1600) ; Statement: r1 := @this: org.apache.dubbo.rpc.protocol.tri.RequestPath 
(assert (not (= var2586 null-var1600)))
(define-const var3853 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3853)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3853!1 String)
(assert (= var3853!1 ""))
(define-const var2897 String (path/953008138 var2586)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String path> 
(assert true)
(define-const var3685 String (append/672562846 var3853!1 var2897)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2) 
(declare-const var3853!2 String)
(assert (= var3853!2 (str.++ var3853!1 var2897)))
(assert true)
(define-const var2360 String (append/-1166366385 var3685 47)) ; Statement: $r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47) 
(declare-const var3685!1 String)
(assert (str.prefixof var3685 var3685!1))
(define-const var2543 String (methodName/953008138 var2586)) ; Statement: $r4 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String methodName> 
(assert true)
(define-const var2069 String (append/672562846 var2360 var2543)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4) 
(declare-const var2360!1 String)
(assert (= var2360!1 (str.++ var2360 var2543)))
(assert true)
(define-const var511 String (toString/-2075883882 var2069)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r7 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), path/953008138=([org.apache.dubbo.rpc.protocol.tri.RequestPath], java.lang.String), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), methodName/953008138=([org.apache.dubbo.rpc.protocol.tri.RequestPath], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1600=org.apache.dubbo.rpc.protocol.tri.RequestPath, var2586=r1, var3853=$r0, var2897=$r2, var3685=$r3, var2360=$r5, var2543=$r4, var2069=$r6, var511=$r7}
; {org.apache.dubbo.rpc.protocol.tri.RequestPath=var1600, r1=var2586, $r0=var3853, $r2=var2897, $r3=var3685, $r5=var2360, $r4=var2543, $r6=var2069, $r7=var511}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.protocol.tri.RequestPath;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r2 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String path>;	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r2);	$r5 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(47);	$r4 = r1.<org.apache.dubbo.rpc.protocol.tri.RequestPath: java.lang.String methodName>;	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r4);	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.String toString()>();	return $r7
;block_num 1