(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

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

(declare-sort var3320 0)
(declare-sort var3512 0)
(declare-sort var498 0)
(declare-sort var49 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var3512_fromSieveNameToIndex/-130439496 (String (Array Int String)) Int)
(declare-fun var498-init () var498)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun <init>/-1233509352 (var498 var49 var49) void)
(declare-fun cast-from-Int-to-var49 (Int) var49)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var1306 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1306 null-String)))
(declare-const var1598 (Array Int String)) ; Statement: r11 := @parameter1: java.lang.String[] 
(assert (not (= var1598 null-__Array__Int__String__)))
; split operation: var2133 = var1306.split("<") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("<") 
(define-const var3196 Int (get_split_length var1306 "<" (- 1))) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 2 goto $r2 = new java.lang.IllegalArgumentException 
(assert (not (not (= var3196 2)))) ; Negate: Cond: $i0 != 2  
(define-const var3862 String (get_split_element var1306 "<" (- 1) 0)) ; Statement: $r7 = r1[0] 
(assert true)
(define-const var1185 String (trim/-847153721 var3862)) ; Statement: r8 = virtualinvoke $r7.<java.lang.String: java.lang.String trim()>() 
(define-const var1206 String (get_split_element var1306 "<" (- 1) 1)) ; Statement: $r9 = r1[1] 
(assert true)
(define-const var2715 String (trim/-847153721 var1206)) ; Statement: r10 = virtualinvoke $r9.<java.lang.String: java.lang.String trim()>() 
(define-const var3375 Int (var3512_fromSieveNameToIndex/-130439496 var1185 var1598)) ; Statement: i1 = staticinvoke <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: int fromSieveNameToIndex(java.lang.String,java.lang.String[])>(r8, r11) 
(define-const var526 Int (var3512_fromSieveNameToIndex/-130439496 var2715 var1598)) ; Statement: i2 = staticinvoke <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: int fromSieveNameToIndex(java.lang.String,java.lang.String[])>(r10, r11) 
(define-const var1215 var498 var498-init) ; Statement: $r12 = new edu.stanford.nlp.util.Pair 
(define-const var2305 Int (Int_valueOf/-1371140006 var3375)) ; Statement: $r14 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i1) 
(define-const var3501 Int (Int_valueOf/-1371140006 var526)) ; Statement: $r13 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i2) 
(assert true)
;(assert (<init>/-1233509352 var1215 (cast-from-Int-to-var49 var2305) (cast-from-Int-to-var49 var3501))) ; Statement: specialinvoke $r12.<edu.stanford.nlp.util.Pair: void <init>(java.lang.Object,java.lang.Object)>($r14, $r13) 

(declare-const var1215!1 var498)
(declare-const var2305!1 Int)
(declare-const var3501!1 Int)
 ; Statement: return $r12 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), var3512_fromSieveNameToIndex/-130439496=([java.lang.String, java.lang.String[]], int), var498-init=([], edu.stanford.nlp.util.Pair), Int_valueOf/-1371140006=([int], java.lang.Integer), <init>/-1233509352=([edu.stanford.nlp.util.Pair, java.lang.Object, java.lang.Object], void), cast-from-Int-to-var49=([java.lang.Integer], java.lang.Object)}
; {var1306=r0, var3320=null_type, var1598=r11, var2133=r1, var3196=$i0, var3862=$r7, var1185=r8, var1206=$r9, var2715=r10, var3512=edu.stanford.nlp.dcoref.SieveCoreferenceSystem, var3375=i1, var526=i2, var498=edu.stanford.nlp.util.Pair, var1215=$r12, var2305=$r14, var3501=$r13, var49=java.lang.Object}
; {r0=var1306, null_type=var3320, r11=var1598, r1=var2133, $i0=var3196, $r7=var3862, r8=var1185, $r9=var1206, r10=var2715, edu.stanford.nlp.dcoref.SieveCoreferenceSystem=var3512, i1=var3375, i2=var526, edu.stanford.nlp.util.Pair=var498, $r12=var1215, $r14=var2305, $r13=var3501, java.lang.Object=var49}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String trim()>": 2}
;stmts r0 := @parameter0: java.lang.String;	r11 := @parameter1: java.lang.String[];	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("<");	$i0 = lengthof r1;	if $i0 != 2 goto $r2 = new java.lang.IllegalArgumentException;	$r7 = r1[0];	r8 = virtualinvoke $r7.<java.lang.String: java.lang.String trim()>();	$r9 = r1[1];	r10 = virtualinvoke $r9.<java.lang.String: java.lang.String trim()>();	i1 = staticinvoke <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: int fromSieveNameToIndex(java.lang.String,java.lang.String[])>(r8, r11);	i2 = staticinvoke <edu.stanford.nlp.dcoref.SieveCoreferenceSystem: int fromSieveNameToIndex(java.lang.String,java.lang.String[])>(r10, r11);	$r12 = new edu.stanford.nlp.util.Pair;	$r14 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i1);	$r13 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i2);	specialinvoke $r12.<edu.stanford.nlp.util.Pair: void <init>(java.lang.Object,java.lang.Object)>($r14, $r13);	return $r12
;block_num 2
(exit)
