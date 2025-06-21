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

(declare-sort var2367 0)
(declare-sort var956 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cause/195094363 (var2367) var956)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun description/195094363 (var2367) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2367 var2367)
(declare-const null-var956 var956)
(declare-const var1956 var2367) ; Statement: r0 := @this: org.apache.dubbo.rpc.TriRpcStatus 
(assert (not (= var1956 null-var2367)))
(define-const var190 var956 (cause/195094363 var1956)) ; Statement: $r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.Throwable cause> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
(assert (not (not (= var190 null-var956)))) ; Negate: Cond: $r1 != null  
(define-const var145 String String-init) ; Statement: $r8 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var145)) ; Statement: specialinvoke $r8.<java.lang.StringBuilder: void <init>()>() 
(declare-const var145!1 String)
(assert (= var145!1 ""))
(assert true)
(define-const var2673 String (append/672562846 var145!1 "")) ; Statement: $r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("") 
(declare-const var145!2 String)
(assert (= var145!2 (str.++ var145!1 "")))
(define-const var741 String (description/195094363 var1956)) ; Statement: $r9 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description> 
(assert true)
(define-const var3968 String (append/672562846 var2673 var741)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9) 
(declare-const var2673!1 String)
(assert (= var2673!1 (str.++ var2673 var741)))
(assert true)
(define-const var3367 String (toString/-2075883882 var3968)) ; Statement: r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: goto [?= return r12] 
(assert true) ; Non Conditional
 ; Statement: return r12 
(check-sat)
; {cause/195094363=([org.apache.dubbo.rpc.TriRpcStatus], java.lang.Throwable), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), description/195094363=([org.apache.dubbo.rpc.TriRpcStatus], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2367=org.apache.dubbo.rpc.TriRpcStatus, var1956=r0, var956=java.lang.Throwable, var190=$r1, var145=$r8, var2673=$r10, var741=$r9, var3968=$r11, var3367=r12}
; {org.apache.dubbo.rpc.TriRpcStatus=var2367, r0=var1956, java.lang.Throwable=var956, $r1=var190, $r8=var145, $r10=var2673, $r9=var741, $r11=var3968, r12=var3367}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.TriRpcStatus;	$r1 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.Throwable cause>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	$r8 = new java.lang.StringBuilder;	specialinvoke $r8.<java.lang.StringBuilder: void <init>()>();	$r10 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("");	$r9 = r0.<org.apache.dubbo.rpc.TriRpcStatus: java.lang.String description>;	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r9);	r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.String toString()>();	goto [?= return r12];	return r12
;block_num 3