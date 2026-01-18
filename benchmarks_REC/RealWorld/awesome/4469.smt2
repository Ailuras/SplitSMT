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

(declare-sort var265 0)
(declare-sort var2340 0)
(declare-sort var2578 0)
(declare-sort var3680 0)
(declare-sort var3712 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var3680!class ClassObject)
(declare-fun var2578_valueOf/2134747254 (ClassObject String) var2578)
(declare-fun cast-from-var2578-to-var3680 (var2578) var3680)
(declare-fun var265_put/1464166817 (var265 var3712 var3712) var3712)
(declare-fun cast-from-String-to-var3712 (String) var3712)
(declare-fun cast-from-var3680-to-var3712 (var3680) var3712)
(declare-const null-var265 var265)
(declare-const null-String String)
(declare-const var902 var265) ; Statement: r5 := @parameter0: java.util.Map 
(assert (not (= var902 null-var265)))
(declare-const var2018 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2018 null-String)))
; split operation: var3544 = var2018.split(", ") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(", ") 
(define-const var273 String (get_split_element var2018 ", " (- 1) 0)) ; Statement: $r2 = r1[0] 
(define-const var1450 var2578 (var2578_valueOf/2134747254 var3680!class var273)) ; Statement: $r3 = staticinvoke <java.lang.Enum: java.lang.Enum valueOf(java.lang.Class,java.lang.String)>(class "Lorg/jline/utils/InfoCmp$Capability;", $r2) 
(define-const var844 var3680 (cast-from-var2578-to-var3680 var1450)) ; Statement: r4 = (org.jline.utils.InfoCmp$Capability) $r3 
(define-const var3283 String (get_split_element var2018 ", " (- 1) 0)) ; Statement: $r6 = r1[0] 
;(assert (var265_put/1464166817 var902 (cast-from-String-to-var3712 var3283) (cast-from-var3680-to-var3712 var844))) ; Statement: interfaceinvoke r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r6, r4) 

(declare-const var902!1 var265)
(declare-const var3283!1 String)
(declare-const var844!1 var3680)
(define-const var3232 String (get_split_element var2018 ", " (- 1) 1)) ; Statement: $r7 = r1[1] 
;(assert (var265_put/1464166817 var902!1 (cast-from-String-to-var3712 var3232) (cast-from-var3680-to-var3712 var844!1))) ; Statement: interfaceinvoke r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r7, r4) 

(declare-const var902!2 var265)
(declare-const var3232!1 String)
(declare-const var844!2 var3680)
 ; Statement: return 
; {var2578_valueOf/2134747254=([java.lang.Class, java.lang.String], java.lang.Enum), cast-from-var2578-to-var3680=([java.lang.Enum], org.jline.utils.InfoCmp$Capability), var265_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3712=([java.lang.String], java.lang.Object), cast-from-var3680-to-var3712=([org.jline.utils.InfoCmp$Capability], java.lang.Object)}
; {var265=java.util.Map, var902=r5, var2018=r0, var2340=null_type, var3544=r1, var273=$r2, var2578=java.lang.Enum, var3680=org.jline.utils.InfoCmp$Capability, var1450=$r3, var844=r4, var3283=$r6, var3712=java.lang.Object, var3232=$r7}
; {java.util.Map=var265, r5=var902, r0=var2018, null_type=var2340, r1=var3544, $r2=var273, java.lang.Enum=var2578, org.jline.utils.InfoCmp$Capability=var3680, $r3=var1450, r4=var844, $r6=var3283, java.lang.Object=var3712, $r7=var3232}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @parameter0: java.util.Map;	r0 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(", ");	$r2 = r1[0];	$r3 = staticinvoke <java.lang.Enum: java.lang.Enum valueOf(java.lang.Class,java.lang.String)>(class "Lorg/jline/utils/InfoCmp$Capability;", $r2);	r4 = (org.jline.utils.InfoCmp$Capability) $r3;	$r6 = r1[0];	interfaceinvoke r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r6, r4);	$r7 = r1[1];	interfaceinvoke r5.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>($r7, r4);	return
;block_num 1
(check-sat)
(exit)
