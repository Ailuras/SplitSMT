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

(declare-sort var2931 0)
(declare-sort var1530 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2931_values/-1928228341 () (Array Int var2931))
(declare-fun getLength-Arr-var2931-1 ((Array Int var2931)) Int)
(declare-fun var1530-init () var1530)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1092629202 (var1530 String) void)
(declare-const null-Int Int)
(declare-const var3472 Int) ; Statement: i1 := @parameter0: int 
(assert (not (= var3472 null-Int)))
(define-const var2991 (Array Int var2931) var2931_values/-1928228341) ; Statement: r0 = staticinvoke <org.apache.dubbo.rpc.TriRpcStatus$Code: org.apache.dubbo.rpc.TriRpcStatus$Code[] values()>() 
(define-const var588 Int (getLength-Arr-var2931-1 var2991)) ; Statement: i0 = lengthof r0 
(define-const var1977 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto $r1 = new java.lang.IllegalStateException 
(assert (>= var1977 var588)) ; Cond: i3 >= i0 
(define-const var215 var1530 var1530-init) ; Statement: $r1 = new java.lang.IllegalStateException 
(define-const var3299 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3299)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3299!1 String)
(assert (= var3299!1 ""))
(assert true)
(define-const var3885 String (append/672562846 var3299!1 "Can not find status for code: ")) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can not find status for code: ") 
(declare-const var3299!2 String)
(assert (= var3299!2 (str.++ var3299!1 "Can not find status for code: ")))
(assert true)
(define-const var3110 String (append/-1001720160 var3885 var3472)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var3885!1 String)
(assert (str.prefixof var3885 var3885!1))
(assert true)
(define-const var713 String (toString/-2075883882 var3110)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1092629202 var215 var713)) ; Statement: specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r5) 

(declare-const var215!1 var1530)
(declare-const var713!1 String)
 ; Statement: throw $r1 
(check-sat)
; {var2931_values/-1928228341=([], org.apache.dubbo.rpc.TriRpcStatus$Code[]), getLength-Arr-var2931-1=([org.apache.dubbo.rpc.TriRpcStatus$Code[]], int), var1530-init=([], java.lang.IllegalStateException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1092629202=([java.lang.IllegalStateException, java.lang.String], void)}
; {var3472=i1, var2931=org.apache.dubbo.rpc.TriRpcStatus$Code, var2991=r0, var588=i0, var1977=i3, var1530=java.lang.IllegalStateException, var215=$r1, var3299=$r2, var3885=$r3, var3110=$r4, var713=$r5}
; {i1=var3472, org.apache.dubbo.rpc.TriRpcStatus$Code=var2931, r0=var2991, i0=var588, i3=var1977, java.lang.IllegalStateException=var1530, $r1=var215, $r2=var3299, $r3=var3885, $r4=var3110, $r5=var713}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts i1 := @parameter0: int;	r0 = staticinvoke <org.apache.dubbo.rpc.TriRpcStatus$Code: org.apache.dubbo.rpc.TriRpcStatus$Code[] values()>();	i0 = lengthof r0;	i3 = 0;	if i3 >= i0 goto $r1 = new java.lang.IllegalStateException;	$r1 = new java.lang.IllegalStateException;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Can not find status for code: ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r1.<java.lang.IllegalStateException: void <init>(java.lang.String)>($r5);	throw $r1
;block_num 3