(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_at_re (String RegLan Int) String)
(declare-fun split_rest_re (String RegLan Int) String)
(declare-fun num_splits_re (String RegLan) Int)
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits x d) limit)
         (num_splits x d)
         limit)
    (num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits x d) limit))
    (split_rest x d (- limit 1))
    (split_at x d i)
  )
)

(define-fun get_split_length_re ((x String) (d RegLan) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (num_splits_re x d) limit)
         (num_splits_re x d)
         limit)
    (num_splits_re x d)
  )
)

(declare-sort var2259 0)
(declare-sort var376 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var376-init () var376)
(declare-fun <init>/-325640736 (var376) void)
(declare-const null-String String)
(declare-const var2022 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var2022 null-String)))
 ; Statement: if r4 != null goto $r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *") 
(assert (not (= var2022 null-String))) ; Cond: r4 != null 
; split operation: var1207 = var2022.split(" *, *") ; Statement: $r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *") 
(define-const var1936 var376 var376-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1936)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1936!1 var376)
(define-const var3748 Int (get_split_length_re var2022 (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{09}"))) (str.to_re ",") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i0 = lengthof $r3 
(define-const var1395 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return $r0 
(assert (>= var1395 var3748)) ; Cond: i1 >= $i0 
 ; Statement: return $r0 
; {var376-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void)}
; {var2022=r4, var2259=null_type, var1207=$r3, var376=java.util.ArrayList, var1936=$r0, var3748=$i0, var1395=i1}
; {r4=var2022, null_type=var2259, $r3=var1207, java.util.ArrayList=var376, $r0=var1936, $i0=var3748, i1=var1395}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.lang.String;	if r4 != null goto $r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *");	$r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *");	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$i0 = lengthof $r3;	i1 = 0;	if i1 >= $i0 goto return $r0;	return $r0
;block_num 4
(check-sat)
(exit)
