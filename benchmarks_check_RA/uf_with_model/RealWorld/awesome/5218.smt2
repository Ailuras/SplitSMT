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

(define-fun get_split_element_re ((x String) (d RegLan) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (num_splits_re x d) limit))
    (split_rest_re x d (- limit 1))
    (split_at_re x d i)
  )
)

(declare-sort var292 0)
(declare-sort var3722 0)
(declare-sort var130 0)
(declare-sort var604 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3722-init () var3722)
(declare-fun <init>/-325640736 (var3722) void)
(declare-fun var130_getSieves/-107895238 (var292) String)
(declare-fun var130_getCurrentSieveForTrain/-1427544085 (var292) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var292 var292)
(declare-const null-String String)
(declare-const var2909 var292) ; Statement: r1 := @parameter0: java.util.Properties 
(assert (not (= var2909 null-var292)))
(define-const var1308 var3722 var3722-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1308)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1308!1 var3722)
(define-const var1452 String (var130_getSieves/-107895238 var2909)) ; Statement: r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1) 
(define-const var1642 String (var130_getCurrentSieveForTrain/-1427544085 var2909)) ; Statement: r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1) 
 ; Statement: if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3) 
(assert (not (= var1642 null-String))) ; Cond: r3 != null 
; split operation: var271 = var1452.split(var1642) ; Statement: $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3) 
(define-const var966 String (get_split_element var1452 var1642 (- 1) 0)) ; Statement: $r5 = $r4[0] 
(assert true)
(define-const var2722 String (trim/-847153721 var966)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.String: java.lang.String trim()>() 
; split operation: var1817 = var2722.split(",\u005cs*") ; Statement: $r11 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
(assert true) ; Non Conditional
(declare-const var1817 (Array Int String))
(define-const var1073 (Array Int String) var1817) ; Statement: r7 = $r11 
(define-const var3817 Int (get_split_length_re var2722 (re.++ (str.to_re ",") (re.* (re.union (str.to_re " ") (str.to_re "\u{09}")))) (- 1))) ; Statement: $i0 = lengthof $r11 
(define-const var386 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return $r0 
(assert (>= var386 var3817)) ; Cond: i1 >= $i0 
 ; Statement: return $r0 
; {var3722-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var130_getSieves/-107895238=([java.util.Properties], java.lang.String), var130_getCurrentSieveForTrain/-1427544085=([java.util.Properties], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var292=java.util.Properties, var2909=r1, var3722=java.util.ArrayList, var1308=$r0, var130=edu.stanford.nlp.coref.hybrid.HybridCorefProperties, var1452=r2, var1642=r3, var604=null_type, var271=$r4, var966=$r5, var2722=$r6, var1817=$r11, var1073=r7, var3817=$i0, var386=i1}
; {java.util.Properties=var292, r1=var2909, java.util.ArrayList=var3722, $r0=var1308, edu.stanford.nlp.coref.hybrid.HybridCorefProperties=var130, r2=var1452, r3=var1642, null_type=var604, $r4=var271, $r5=var966, $r6=var2722, $r11=var1817, r7=var1073, $i0=var3817, i1=var386}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r1 := @parameter0: java.util.Properties;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1);	r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1);	if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3);	$r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3);	$r5 = $r4[0];	$r6 = virtualinvoke $r5.<java.lang.String: java.lang.String trim()>();	$r11 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	r7 = $r11;	$i0 = lengthof $r11;	i1 = 0;	if i1 >= $i0 goto return $r0;	return $r0
;block_num 5
(check-sat)
(get-model)
(exit)
