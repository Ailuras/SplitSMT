(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

(declare-sort var2682 0)
(declare-sort var1345 0)
(declare-sort var2633 0)
(declare-sort var2897 0)
(declare-sort var2411 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun replaceFirst/750800361 (String String String) String)
(declare-fun var1345-init () var1345)
(declare-fun <init>/927978603 (var1345) void)
(declare-fun var2633-init () var2633)
(declare-fun <init>/871497512 (var2633 var2897 var2411) void)
(declare-fun cast-from-var1345-to-var2897 (var1345) var2897)
(declare-fun cast-from-String-to-var2411 (String) var2411)
(declare-const null-String String)
(declare-const var2265 String) ; Statement: r13 := @parameter0: java.lang.String 
(assert (not (= var2265 null-String)))
(assert true)
(define-const var3629 String (replaceFirst/750800361 var2265 "#.*$" "")) ; Statement: r14 = virtualinvoke r13.<java.lang.String: java.lang.String replaceFirst(java.lang.String,java.lang.String)>("#.*$", "") 
(assert (= (replaceFirst/750800361 var2265 "#.*$" "") (str.replace_re var2265 (re.++ (str.to_re "#") (re.* re.allchar) (str.to_re "$")) "")))
; split operation: var297 = var3629.split("\u005cs+") ; Statement: r0 = virtualinvoke r14.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1061 var1345 var1345-init) ; Statement: $r1 = new edu.stanford.nlp.stats.ClassicCounter 
(assert true)
;(assert (<init>/927978603 var1061)) ; Statement: specialinvoke $r1.<edu.stanford.nlp.stats.ClassicCounter: void <init>()>() 

(declare-const var1061!1 var1345)
(define-const var2273 Int 1) ; Statement: i2 = 1 
(assert true) ; Non Conditional
(define-const var280 Int (get_split_length var3629 "\u005cs+" (- 1))) ; Statement: $i0 = lengthof r0 
 ; Statement: if i2 >= $i0 goto $r2 = new edu.stanford.nlp.ling.RVFDatum 
(assert (>= var2273 var280)) ; Cond: i2 >= $i0 
(define-const var3292 var2633 var2633-init) ; Statement: $r2 = new edu.stanford.nlp.ling.RVFDatum 
(define-const var824 String (get_split_element var3629 "\u005cs+" (- 1) 0)) ; Statement: $r3 = r0[0] 
(assert true)
;(assert (<init>/871497512 var3292 (cast-from-var1345-to-var2897 var1061!1) (cast-from-String-to-var2411 var824))) ; Statement: specialinvoke $r2.<edu.stanford.nlp.ling.RVFDatum: void <init>(edu.stanford.nlp.stats.Counter,java.lang.Object)>($r1, $r3) 

(declare-const var3292!1 var2633)
(declare-const var1061!2 var1345)
(declare-const var824!1 String)
 ; Statement: return $r2 
(check-sat)
; {replaceFirst/750800361=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), var1345-init=([], edu.stanford.nlp.stats.ClassicCounter), <init>/927978603=([edu.stanford.nlp.stats.ClassicCounter], void), var2633-init=([], edu.stanford.nlp.ling.RVFDatum), <init>/871497512=([edu.stanford.nlp.ling.RVFDatum, edu.stanford.nlp.stats.Counter, java.lang.Object], void), cast-from-var1345-to-var2897=([edu.stanford.nlp.stats.ClassicCounter], edu.stanford.nlp.stats.Counter), cast-from-String-to-var2411=([java.lang.String], java.lang.Object)}
; {var2265=r13, var2682=null_type, var3629=r14, var297=r0, var1345=edu.stanford.nlp.stats.ClassicCounter, var1061=$r1, var2273=i2, var280=$i0, var2633=edu.stanford.nlp.ling.RVFDatum, var3292=$r2, var824=$r3, var2897=edu.stanford.nlp.stats.Counter, var2411=java.lang.Object}
; {r13=var2265, null_type=var2682, r14=var3629, r0=var297, edu.stanford.nlp.stats.ClassicCounter=var1345, $r1=var1061, i2=var2273, $i0=var280, edu.stanford.nlp.ling.RVFDatum=var2633, $r2=var3292, $r3=var824, edu.stanford.nlp.stats.Counter=var2897, java.lang.Object=var2411}
;seq <java.lang.String: java.lang.String replaceFirst(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String replaceFirst(java.lang.String,java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r13 := @parameter0: java.lang.String;	r14 = virtualinvoke r13.<java.lang.String: java.lang.String replaceFirst(java.lang.String,java.lang.String)>("#.*$", "");	r0 = virtualinvoke r14.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r1 = new edu.stanford.nlp.stats.ClassicCounter;	specialinvoke $r1.<edu.stanford.nlp.stats.ClassicCounter: void <init>()>();	i2 = 1;	$i0 = lengthof r0;	if i2 >= $i0 goto $r2 = new edu.stanford.nlp.ling.RVFDatum;	$r2 = new edu.stanford.nlp.ling.RVFDatum;	$r3 = r0[0];	specialinvoke $r2.<edu.stanford.nlp.ling.RVFDatum: void <init>(edu.stanford.nlp.stats.Counter,java.lang.Object)>($r1, $r3);	return $r2
;block_num 3
(exit)
