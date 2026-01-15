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

(declare-sort var924 0)
(declare-sort var1128 0)
(declare-sort var2088 0)
(declare-sort var3240 0)
(declare-sort var2286 0)
(declare-sort var1046 0)
(declare-sort var798 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3240-init () var3240)
(declare-fun <init>/-707998177 (var3240) void)
(declare-fun omitComments/-1276310728 (var924) Bool)
(declare-fun store/877702891 (var2286 var1128 String) void)
(declare-fun cast-from-var924-to-var2286 (var924) var2286)
(declare-fun cast-from-var3240-to-var1128 (var3240) var1128)
(declare-fun toString/-372517094 (var3240 var1046) String)
(declare-const null-var924 var924)
(declare-const null-var1128 var1128)
(declare-const null-String String)
(declare-const var798-ISO_8859_1 var1046)
(declare-const var924-EOL String)
(declare-const var2405 var924) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var2405 null-var924)))
(declare-const var3477 var1128) ; Statement: r6 := @parameter0: java.io.OutputStream 
(assert (not (= var3477 null-var1128)))
(declare-const var1222 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1222 null-String)))
(define-const var3677 var3240 var3240-init) ; Statement: $r0 = new java.io.ByteArrayOutputStream 
(assert true)
;(assert (<init>/-707998177 var3677)) ; Statement: specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>() 

(declare-const var3677!1 var3240)
(define-const var534 Bool (omitComments/-1276310728 var2405)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r13 = r2 
(assert (= (ite var534 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2654 String var1222) ; Statement: $r13 = r2 
(assert true) ; Non Conditional
(assert true)
;(assert (store/877702891 (cast-from-var924-to-var2286 var2405) (cast-from-var3240-to-var1128 var3677!1) var2654)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13) 

(declare-const var2405!1 var924)
(declare-const var3677!2 var3240)
(declare-const var2654!1 String)
(define-const var726 var1046 var798-ISO_8859_1) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1> 
(assert true)
(define-const var890 String (toString/-372517094 var3677!2 var726)) ; Statement: $r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3) 
(define-const var659 String var924-EOL) ; Statement: $r4 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var1071 = var890.split(var659) ; Statement: $r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4) 
(define-const var227 Int (get_split_length_re var890 (re.union (str.to_re "\u{0D}") (str.to_re "\u{0A}")) (- 1))) ; Statement: $i0 = lengthof $r12 
(define-const var192 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var192 var227)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var3240-init=([], java.io.ByteArrayOutputStream), <init>/-707998177=([java.io.ByteArrayOutputStream], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/877702891=([java.util.Properties, java.io.OutputStream, java.lang.String], void), cast-from-var924-to-var2286=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var3240-to-var1128=([java.io.ByteArrayOutputStream], java.io.OutputStream), toString/-372517094=([java.io.ByteArrayOutputStream, java.nio.charset.Charset], java.lang.String)}
; {var924=org.springframework.core.SortedProperties, var2405=r1, var1128=java.io.OutputStream, var3477=r6, var1222=r2, var2088=null_type, var3240=java.io.ByteArrayOutputStream, var3677=$r0, var534=$z0, var2654=$r13, var2286=java.util.Properties, var1046=java.nio.charset.Charset, var798=java.nio.charset.StandardCharsets, var726=$r3, var890=$r11, var659=$r4, var1071=$r12, var227=$i0, var192=i1}
; {org.springframework.core.SortedProperties=var924, r1=var2405, java.io.OutputStream=var1128, r6=var3477, r2=var1222, null_type=var2088, java.io.ByteArrayOutputStream=var3240, $r0=var3677, $z0=var534, $r13=var2654, java.util.Properties=var2286, java.nio.charset.Charset=var1046, java.nio.charset.StandardCharsets=var798, $r3=var726, $r11=var890, $r4=var659, $r12=var1071, $i0=var227, i1=var192}
;seq <java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r6 := @parameter0: java.io.OutputStream;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.ByteArrayOutputStream;	specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r13 = r2;	$r13 = r2;	specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13);	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1>;	$r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3);	$r4 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4);	$i0 = lengthof $r12;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5
(exit)
