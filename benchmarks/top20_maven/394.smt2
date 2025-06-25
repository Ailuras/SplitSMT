(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3346 0)
(declare-sort var1971 0)
(declare-sort var293 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getDefaultRangeDelimiter/404173179 (var3346) String)
(declare-fun var293_quote/811834350 (String) String)
(declare-const null-var3346 var3346)
(declare-const null-String String)
(declare-const var3351 var3346) ; Statement: r1 := @this: ch.qos.logback.classic.pattern.CallerDataConverter 
(assert (not (= var3351 null-var3346)))
(declare-const var226 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var226 null-String)))
(assert true)
(define-const var1631 String (getDefaultRangeDelimiter/404173179 var3351)) ; Statement: $r2 = virtualinvoke r1.<ch.qos.logback.classic.pattern.CallerDataConverter: java.lang.String getDefaultRangeDelimiter()>() 
(define-const var3887 String (var293_quote/811834350 var1631)) ; Statement: $r3 = staticinvoke <java.util.regex.Pattern: java.lang.String quote(java.lang.String)>($r2) 
; split operation: var494 = var226.split(var3887, 2) ; Statement: $r4 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r3, 2) 
 ; Statement: return $r4 
(check-sat)
; {getDefaultRangeDelimiter/404173179=([ch.qos.logback.classic.pattern.CallerDataConverter], java.lang.String), var293_quote/811834350=([java.lang.String], java.lang.String)}
; {var3346=ch.qos.logback.classic.pattern.CallerDataConverter, var3351=r1, var226=r0, var1971=null_type, var1631=$r2, var293=java.util.regex.Pattern, var3887=$r3, var494=$r4}
; {ch.qos.logback.classic.pattern.CallerDataConverter=var3346, r1=var3351, r0=var226, null_type=var1971, $r2=var1631, java.util.regex.Pattern=var293, $r3=var3887, $r4=var494}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r1 := @this: ch.qos.logback.classic.pattern.CallerDataConverter;	r0 := @parameter0: java.lang.String;	$r2 = virtualinvoke r1.<ch.qos.logback.classic.pattern.CallerDataConverter: java.lang.String getDefaultRangeDelimiter()>();	$r3 = staticinvoke <java.util.regex.Pattern: java.lang.String quote(java.lang.String)>($r2);	$r4 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r3, 2);	return $r4
;block_num 1