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

(declare-sort var217 0)
(declare-sort var3520 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3520-init () var3520)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3520 String) void)
(declare-const null-var217 var217)
(declare-const null-Int Int)
(declare-const var2196 var217) ; Statement: r7 := @this: org.apache.dubbo.remoting.buffer.DirectChannelBufferFactory 
(assert (not (= var2196 null-var217)))
(declare-const var2097 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var2097 null-Int)))
 ; Statement: if i0 >= 0 goto (branch) 
(assert (not (>= var2097 0))) ; Negate: Cond: i0 >= 0  
(define-const var2627 var3520 var3520-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var155 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var155)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var155!1 String)
(assert (= var155!1 ""))
(assert true)
(define-const var1059 String (append/672562846 var155!1 "capacity: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("capacity: ") 
(declare-const var155!2 String)
(assert (= var155!2 (str.++ var155!1 "capacity: ")))
(assert true)
(define-const var1449 String (append/-1001720160 var1059 var2097)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var1059!1 String)
(assert (str.prefixof var1059 var1059!1))
(assert true)
(define-const var738 String (toString/-2075883882 var1449)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2627 var738)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var2627!1 var3520)
(declare-const var738!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var3520-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var217=org.apache.dubbo.remoting.buffer.DirectChannelBufferFactory, var2196=r7, var2097=i0, var3520=java.lang.IllegalArgumentException, var2627=$r2, var155=$r3, var1059=$r4, var1449=$r5, var738=$r6}
; {org.apache.dubbo.remoting.buffer.DirectChannelBufferFactory=var217, r7=var2196, i0=var2097, java.lang.IllegalArgumentException=var3520, $r2=var2627, $r3=var155, $r4=var1059, $r5=var1449, $r6=var738}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r7 := @this: org.apache.dubbo.remoting.buffer.DirectChannelBufferFactory;	i0 := @parameter0: int;	if i0 >= 0 goto (branch);	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("capacity: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2