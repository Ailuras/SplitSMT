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

(declare-sort var3917 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-const null-String String)
(declare-const var1595 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1595 null-String)))
(assert true)
(define-const var279 Int (indexOf/-1209756239 var1595 "/")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/") 
(assert true)
(define-const var2763 Int (indexOf/-1209756239 var1595 ":")) ; Statement: i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":") 
(define-const var3046 Int (cast-from-Int-to-Int -1)) ; Statement: $i6 = (int) -1 
 ; Statement: if i0 != $i6 goto $i2 = i0 + 1 
(assert (not (not (= var279 var3046)))) ; Negate: Cond: i0 != $i6  
(define-const var3256 Int 0) ; Statement: $i2 = 0 
 ; Statement: goto [?= i3 = $i2] 
(assert true) ; Non Conditional
(define-const var1531 Int var3256) ; Statement: i3 = $i2 
(define-const var2721 Int (cast-from-Int-to-Int -1)) ; Statement: $i8 = (int) -1 
 ; Statement: if i1 != $i8 goto $i4 = i1 
(assert (not (not (= var2763 var2721)))) ; Negate: Cond: i1 != $i8  
(assert true)
(define-const var2998 Int (length/-134980193 var1595)) ; Statement: $i4 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: goto [?= $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4)] 
(assert true) ; Non Conditional
(assert (not (and true (and (>= var1531 0) (>= (str.len var1595) var2998) (>= var2998 var1531)))))
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String)}
; {var1595=r0, var3917=null_type, var279=i0, var2763=i1, var3046=$i6, var3256=$i2, var1531=i3, var2721=$i8, var2998=$i4, var102=$r1}
; {r0=var1595, null_type=var3917, i0=var279, i1=var2763, $i6=var3046, $i2=var3256, i3=var1531, $i8=var2721, $i4=var2998, $r1=var102}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 2,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("/");	i1 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":");	$i6 = (int) -1;	if i0 != $i6 goto $i2 = i0 + 1;	$i2 = 0;	goto [?= i3 = $i2];	i3 = $i2;	$i8 = (int) -1;	if i1 != $i8 goto $i4 = i1;	$i4 = virtualinvoke r0.<java.lang.String: int length()>();	goto [?= $r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4)];	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(i3, $i4);	return $r1
;block_num 5