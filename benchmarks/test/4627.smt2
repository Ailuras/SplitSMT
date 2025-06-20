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

(declare-sort var2987 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2987-init () var2987)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/1107025377 (var2987 String) void)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const null-Int Int)
(declare-const var2292 (Array Int Int)) ; Statement: r0 := @parameter0: byte[] 
(assert (not (= var2292 null-__Array__Int__Int__)))
(declare-const var252 Int) ; Statement: i0 := @parameter1: int 
(assert (not (= var252 null-Int)))
(declare-const var2074 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var2074 null-Int)))
(declare-const var2343 (Array Int Int)) ; Statement: r1 := @parameter3: char[] 
(assert (not (= var2343 null-__Array__Int__Int__)))
 ; Statement: if i0 >= 0 goto (branch) 
(assert (>= var252 0)) ; Cond: i0 >= 0 
 ; Statement: if i1 >= 0 goto $i3 = i0 + i1 
(assert (not (>= var2074 0))) ; Negate: Cond: i1 >= 0  
(define-const var924 var2987 var2987-init) ; Statement: $r19 = new java.lang.IndexOutOfBoundsException 
(define-const var3487 String String-init) ; Statement: $r18 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3487)) ; Statement: specialinvoke $r18.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3487!1 String)
(assert (= var3487!1 ""))
(assert true)
(define-const var1154 String (append/672562846 var3487!1 "bytes2base64: length < 0, length is ")) ; Statement: $r6 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("bytes2base64: length < 0, length is ") 
(declare-const var3487!2 String)
(assert (= var3487!2 (str.++ var3487!1 "bytes2base64: length < 0, length is ")))
(assert true)
(define-const var1970 String (append/-1001720160 var1154 var2074)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1) 
(declare-const var1154!1 String)
(assert (str.prefixof var1154 var1154!1))
(assert true)
(define-const var3366 String (toString/-2075883882 var1970)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/1107025377 var924 var3366)) ; Statement: specialinvoke $r19.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r8) 

(declare-const var924!1 var2987)
(declare-const var3366!1 String)
 ; Statement: throw $r19 
(check-sat)
; {var2987-init=([], java.lang.IndexOutOfBoundsException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/1107025377=([java.lang.IndexOutOfBoundsException, java.lang.String], void)}
; {var2292=r0, var252=i0, var2074=i1, var2343=r1, var2987=java.lang.IndexOutOfBoundsException, var924=$r19, var3487=$r18, var1154=$r6, var1970=$r7, var3366=$r8}
; {r0=var2292, i0=var252, i1=var2074, r1=var2343, java.lang.IndexOutOfBoundsException=var2987, $r19=var924, $r18=var3487, $r6=var1154, $r7=var1970, $r8=var3366}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: byte[];	i0 := @parameter1: int;	i1 := @parameter2: int;	r1 := @parameter3: char[];	if i0 >= 0 goto (branch);	if i1 >= 0 goto $i3 = i0 + i1;	$r19 = new java.lang.IndexOutOfBoundsException;	$r18 = new java.lang.StringBuilder;	specialinvoke $r18.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("bytes2base64: length < 0, length is ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>(i1);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r19.<java.lang.IndexOutOfBoundsException: void <init>(java.lang.String)>($r8);	throw $r19
;block_num 3