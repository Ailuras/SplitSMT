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

(declare-sort var126 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var126-init () var126)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1548588776 (var126 String) void)
(declare-const null-Int Int)
(declare-const var666 Int) ; Statement: i0 := @parameter0: int 
(assert (not (= var666 null-Int)))
(define-const var3664 Int (cast-from-Int-to-Int -12)) ; Statement: $i2 = (int) -12 
 ; Statement: if i0 < $i2 goto $r10 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException 
(assert (< var666 var3664)) ; Cond: i0 < $i2 
(define-const var1708 var126 var126-init) ; Statement: $r10 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException 
(define-const var1087 String String-init) ; Statement: $r9 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1087)) ; Statement: specialinvoke $r9.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1087!1 String)
(assert (= var1087!1 ""))
(assert true)
(define-const var969 String (append/672562846 var1087!1 "Invalid timeZone offset ")) ; Statement: $r2 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid timeZone offset ") 
(declare-const var1087!2 String)
(assert (= var1087!2 (str.++ var1087!1 "Invalid timeZone offset ")))
(assert true)
(define-const var2407 String (append/-1001720160 var969 var666)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0) 
(declare-const var969!1 String)
(assert (str.prefixof var969 var969!1))
(assert true)
(define-const var1838 String (toString/-2075883882 var2407)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1548588776 var1708 var1838)) ; Statement: specialinvoke $r10.<org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException: void <init>(java.lang.String)>($r4) 

(declare-const var1708!1 var126)
(declare-const var1838!1 String)
 ; Statement: throw $r10 
(check-sat)
; {cast-from-Int-to-Int=([int], int), var126-init=([], org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1548588776=([org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException, java.lang.String], void)}
; {var666=i0, var3664=$i2, var126=org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException, var1708=$r10, var1087=$r9, var969=$r2, var2407=$r3, var1838=$r4}
; {i0=var666, $i2=var3664, org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException=var126, $r10=var1708, $r9=var1087, $r2=var969, $r3=var2407, $r4=var1838}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts i0 := @parameter0: int;	$i2 = (int) -12;	if i0 < $i2 goto $r10 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException;	$r10 = new org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException;	$r9 = new java.lang.StringBuilder;	specialinvoke $r9.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid timeZone offset ");	$r3 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i0);	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r10.<org.apache.dubbo.rpc.protocol.tri.rest.RestParameterException: void <init>(java.lang.String)>($r4);	throw $r10
;block_num 2