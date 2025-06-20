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

(declare-sort var3956 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun indexOf/-1037706067 ((s String) (c Int)) Int (str.indexof s (str.from_code c) 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var3233 String) ; Statement: r13 := @parameter0: java.lang.String 
(assert (not (= var3233 null-String)))
(define-const var214 String String-init) ; Statement: $r15 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var214)) ; Statement: specialinvoke $r15.<java.lang.StringBuilder: void <init>()>() 
(declare-const var214!1 String)
(assert (= var214!1 ""))
(define-const var905 Int 0) ; Statement: i3 = 0 
(assert true)
(define-const var631 Int (indexOf/-1037706067 var3233 91)) ; Statement: i0 = virtualinvoke r13.<java.lang.String: int indexOf(int)>(91) 
 ; Statement: if i0 <= 0 goto $i4 = i3 
(assert (<= var631 0)) ; Cond: i0 <= 0 
(define-const var1566 Int var905) ; Statement: $i4 = i3 
(define-const var828 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
(define-const var905!1 Int (+ var905 var828)) ; Statement: i3 = i3 + $i6 
 ; Statement: if $i4 <= 0 goto $r1 = "void" 
(assert (<= var1566 0)) ; Cond: $i4 <= 0 
(define-const var3365 String "void") ; Statement: $r1 = "void" 
(assert true)
(define-const var2525 Bool (= var3365 var3233)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r13) 
 ; Statement: if $z0 == 0 goto $r2 = "boolean" 
(assert (not (= (ite var2525 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
;(assert (append/-1166366385 var214!1 86)) ; Statement: virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(86) 
(declare-const var214!2 String)
(assert (str.prefixof var214!1 var214!2))
 ; Statement: goto [?= $r14 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var781 String (toString/-2075883882 var214!2)) ; Statement: $r14 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r14 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), indexOf/-1037706067=([java.lang.String, int], int), cast-from-Int-to-Int=([int], int), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3233=r13, var3956=null_type, var214=$r15, var905=i3, var631=i0, var1566=$i4, var828=$i6, var3365=$r1, var2525=$z0, var781=$r14}
; {r13=var3233, null_type=var3956, $r15=var214, i3=var905, i0=var631, $i4=var1566, $i6=var828, $r1=var3365, $z0=var2525, $r14=var781}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: int indexOf(int)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: int indexOf(int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r13 := @parameter0: java.lang.String;	$r15 = new java.lang.StringBuilder;	specialinvoke $r15.<java.lang.StringBuilder: void <init>()>();	i3 = 0;	i0 = virtualinvoke r13.<java.lang.String: int indexOf(int)>(91);	if i0 <= 0 goto $i4 = i3;	$i4 = i3;	$i6 = (int) -1;	i3 = i3 + $i6;	if $i4 <= 0 goto $r1 = "void";	$r1 = "void";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r13);	if $z0 == 0 goto $r2 = "boolean";	virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(86);	goto [?= $r14 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>()];	$r14 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.String toString()>();	return $r14
;block_num 5