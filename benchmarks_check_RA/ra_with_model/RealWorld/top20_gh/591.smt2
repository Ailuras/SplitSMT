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

(declare-sort var870 0)
(declare-sort var1743 0)
(declare-sort var3350 0)
(declare-sort var2264 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3350-init () var3350)
(declare-fun <init>/-325640736 (var3350) void)
(declare-fun var2264_isEmpty/-153543822 (var2264) Bool)
(declare-fun cast-from-var3350-to-var2264 (var3350) var2264)
(declare-const null-var870 var870)
(declare-const null-String String)
(declare-const var962 var870) ; Statement: r3 := @this: org.springframework.boot.loader.launch.PropertiesLauncher 
(assert (not (= var962 null-var870)))
(declare-const var2232 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2232 null-String)))
(define-const var2113 var3350 var3350-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2113)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2113!1 var3350)
; split operation: var2964 = var2232.split(",") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2128 Int (get_split_length var2232 "," (- 1))) ; Statement: i0 = lengthof r2 
(define-const var448 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
(assert (>= var448 var2128)) ; Cond: i1 >= i0 
(define-const var2050 Bool (var2264_isEmpty/-153543822 (cast-from-var3350-to-var2264 var2113!1))) ; Statement: $z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto return $r0 
(assert (= (ite var2050 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return $r0 
; {var3350-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var2264_isEmpty/-153543822=([java.util.List], boolean), cast-from-var3350-to-var2264=([java.util.ArrayList], java.util.List)}
; {var870=org.springframework.boot.loader.launch.PropertiesLauncher, var962=r3, var2232=r1, var1743=null_type, var3350=java.util.ArrayList, var2113=$r0, var2964=r2, var2128=i0, var448=i1, var2264=java.util.List, var2050=$z0}
; {org.springframework.boot.loader.launch.PropertiesLauncher=var870, r3=var962, r1=var2232, null_type=var1743, java.util.ArrayList=var3350, $r0=var2113, r2=var2964, i0=var2128, i1=var448, java.util.List=var2264, $z0=var2050}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: org.springframework.boot.loader.launch.PropertiesLauncher;	r1 := @parameter0: java.lang.String;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r2;	i1 = 0;	if i1 >= i0 goto $z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	$z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	if $z0 == 0 goto return $r0;	return $r0
;block_num 4
(assert (= null-String ""))
(assert (= var2113 var3350-init))
(assert (= var2050 (var2264_isEmpty/-153543822 (cast-from-var3350-to-var2264 var2113!1))))
(assert (= var2232 ","))
(assert (= var2128 (ite (> (- 1) 0) (ite (< (num_splits var2232 ",") (- 1)) (num_splits var2232 ",") (- 1)) (num_splits var2232 ","))))
(assert (= var448 0))
(check-sat)
(exit)
