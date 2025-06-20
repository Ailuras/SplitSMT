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

(declare-sort var310 0)
(declare-sort var1069 0)
(declare-sort var941 0)
(declare-sort var3125 0)
(declare-sort var3585 0)
(declare-sort var713 0)
(declare-sort var2294 0)
(declare-sort var237 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getInvocationTime/675231966 (var310) var1069)
(declare-fun toInstant/-822818885 (var1069) var941)
(declare-fun var3125_systemDefault/1019915793 () var3125)
(declare-fun var3585_ofInstant/129408697 (var941 var3125) var3585)
(declare-fun format/372879155 (var3585 var713) String)
(declare-fun getOutTime/324948452 (var310) var1069)
(declare-fun get/-1007821573 (var310 String) var2294)
(declare-fun append/-1031950772 (String var2294) String)
(declare-fun append/-1166366385 (String Int) String)
(declare-fun toString/-522406933 (var2294) String)
(declare-fun var237_isNotEmpty/-1251449450 (String) Bool)
(declare-fun cast-from-var2294-to-__Array__Int__ClassObject__ (var2294) (Array Int ClassObject))
(declare-fun getLength-Arr-ClassObject-1 ((Array Int ClassObject)) Int)
(declare-fun cast-from-var2294-to-__Array__Int__var2294__ (var2294) (Array Int var2294))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var310 var310)
(declare-const var310-MESSAGE_DATE_FORMATTER var713)
(declare-const null-var2294 var2294)
(declare-const null-__Array__Int__var2294__ (Array Int var2294))
(declare-const var552 var310) ; Statement: r1 := @this: org.apache.dubbo.rpc.support.AccessLogData 
(assert (not (= var552 null-var310)))
(define-const var3936 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3936)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3936!1 String)
(assert (= var3936!1 ""))
(assert true)
(define-const var1067 String (append/672562846 var3936!1 "[")) ; Statement: $r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var3936!2 String)
(assert (= var3936!2 (str.++ var3936!1 "[")))
(assert true)
(define-const var3519 var1069 (getInvocationTime/675231966 var552)) ; Statement: $r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>() 
(assert true)
(define-const var709 var941 (toInstant/-822818885 var3519)) ; Statement: $r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var325 var3125 var3125_systemDefault/1019915793) ; Statement: $r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var2126 var3585 (var3585_ofInstant/129408697 var709 var325)) ; Statement: $r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3) 
(define-const var445 var713 var310-MESSAGE_DATE_FORMATTER) ; Statement: $r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var2935 String (format/372879155 var2126 var445)) ; Statement: $r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5) 
(assert true)
(define-const var2005 String (append/672562846 var1067 var2935)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7) 
(declare-const var1067!1 String)
(assert (= var1067!1 (str.++ var1067 var2935)))
(assert true)
(define-const var2506 String (append/672562846 var2005 "] ")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var2005!1 String)
(assert (= var2005!1 (str.++ var2005 "] ")))
(assert true)
(define-const var3575 String (append/672562846 var2506 "-> ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ") 
(declare-const var2506!1 String)
(assert (= var2506!1 (str.++ var2506 "-> ")))
(assert true)
(define-const var2190 String (append/672562846 var3575 "[")) ; Statement: $r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[") 
(declare-const var3575!1 String)
(assert (= var3575!1 (str.++ var3575 "[")))
(assert true)
(define-const var2198 var1069 (getOutTime/324948452 var552)) ; Statement: $r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>() 
(assert true)
(define-const var898 var941 (toInstant/-822818885 var2198)) ; Statement: $r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>() 
(define-const var3484 var3125 var3125_systemDefault/1019915793) ; Statement: $r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>() 
(define-const var2983 var3585 (var3585_ofInstant/129408697 var898 var3484)) ; Statement: $r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13) 
(define-const var263 var713 var310-MESSAGE_DATE_FORMATTER) ; Statement: $r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER> 
(assert true)
(define-const var1089 String (format/372879155 var2983 var263)) ; Statement: $r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15) 
(assert true)
(define-const var8 String (append/672562846 var2190 var1089)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17) 
(declare-const var2190!1 String)
(assert (= var2190!1 (str.++ var2190 var1089)))
(assert true)
(define-const var3387 String (append/672562846 var8 "] ")) ; Statement: $r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ") 
(declare-const var8!1 String)
(assert (= var8!1 (str.++ var8 "] ")))
(assert true)
(define-const var1079 var2294 (get/-1007821573 var552 "remote-host")) ; Statement: $r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host") 
(assert true)
(define-const var2593 String (append/-1031950772 var3387 var1079)) ; Statement: $r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20) 
(declare-const var3387!1 String)
(assert (str.prefixof var3387 var3387!1))
(assert true)
(define-const var1572 String (append/-1166366385 var2593 58)) ; Statement: $r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var2593!1 String)
(assert (str.prefixof var2593 var2593!1))
(assert true)
(define-const var3571 var2294 (get/-1007821573 var552 "remote-port")) ; Statement: $r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port") 
(assert true)
(define-const var110 String (append/-1031950772 var1572 var3571)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23) 
(declare-const var1572!1 String)
(assert (str.prefixof var1572 var1572!1))
(assert true)
(define-const var3104 String (append/672562846 var110 " -> ")) ; Statement: $r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ") 
(declare-const var110!1 String)
(assert (= var110!1 (str.++ var110 " -> ")))
(assert true)
(define-const var3541 var2294 (get/-1007821573 var552 "localhost")) ; Statement: $r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost") 
(assert true)
(define-const var1494 String (append/-1031950772 var3104 var3541)) ; Statement: $r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26) 
(declare-const var3104!1 String)
(assert (str.prefixof var3104 var3104!1))
(assert true)
(define-const var658 String (append/-1166366385 var1494 58)) ; Statement: $r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58) 
(declare-const var1494!1 String)
(assert (str.prefixof var1494 var1494!1))
(assert true)
(define-const var123 var2294 (get/-1007821573 var552 "local-port")) ; Statement: $r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port") 
(assert true)
(define-const var1008 String (append/-1031950772 var658 var123)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29) 
(declare-const var658!1 String)
(assert (str.prefixof var658 var658!1))
(assert true)
;(assert (append/672562846 var1008 " - ")) ; Statement: virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ") 
(declare-const var1008!1 String)
(assert (= var1008!1 (str.++ var1008 " - ")))
(assert true)
(define-const var279 var2294 (get/-1007821573 var552 "group")) ; Statement: $r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
 ; Statement: if $r32 == null goto $r47 = "" 
(assert (not (= var279 null-var2294))) ; Negate: Cond: $r32 == null  
(assert true)
(define-const var1792 var2294 (get/-1007821573 var552 "group")) ; Statement: $r46 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group") 
(assert true)
(define-const var3526 String (toString/-522406933 var1792)) ; Statement: $r47 = virtualinvoke $r46.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47)] 
(assert true) ; Non Conditional
(define-const var2085 Bool (var237_isNotEmpty/-1251449450 var3526)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47) 
 ; Statement: if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert (= (ite var2085 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3497 var2294 (get/-1007821573 var552 "service")) ; Statement: $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service") 
(assert true)
;(assert (append/-1031950772 var3936!2 var3497)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33) 
(declare-const var3936!3 String)
(assert (str.prefixof var3936!2 var3936!3))
(assert true)
(define-const var882 var2294 (get/-1007821573 var552 "version")) ; Statement: $r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
 ; Statement: if $r34 == null goto $r48 = "" 
(assert (not (= var882 null-var2294))) ; Negate: Cond: $r34 == null  
(assert true)
(define-const var536 var2294 (get/-1007821573 var552 "version")) ; Statement: $r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version") 
(assert true)
(define-const var2489 String (toString/-522406933 var536)) ; Statement: $r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>() 
 ; Statement: goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)] 
(assert true) ; Non Conditional
(define-const var528 Bool (var237_isNotEmpty/-1251449450 var2489)) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48) 
 ; Statement: if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(assert (= (ite var528 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
;(assert (append/-1166366385 var3936!3 32)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32) 
(declare-const var3936!4 String)
(assert (str.prefixof var3936!3 var3936!4))
(assert true)
(define-const var2036 var2294 (get/-1007821573 var552 "method-name")) ; Statement: $r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name") 
(assert true)
;(assert (append/-1031950772 var3936!4 var2036)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35) 
(declare-const var3936!5 String)
(assert (str.prefixof var3936!4 var3936!5))
(assert true)
;(assert (append/-1166366385 var3936!5 40)) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40) 
(declare-const var3936!6 String)
(assert (str.prefixof var3936!5 var3936!6))
(assert true)
(define-const var2116 var2294 (get/-1007821573 var552 "types")) ; Statement: $r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
 ; Statement: if $r36 == null goto $r49 = newarray (java.lang.Class)[0] 
(assert (not (= var2116 null-var2294))) ; Negate: Cond: $r36 == null  
(assert true)
(define-const var3666 var2294 (get/-1007821573 var552 "types")) ; Statement: $r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types") 
(define-const var423 (Array Int ClassObject) (cast-from-var2294-to-__Array__Int__ClassObject__ var3666)) ; Statement: $r49 = (java.lang.Class[]) $r42 
 ; Statement: goto [?= z2 = 1] 
(assert true) ; Non Conditional
(define-const var3224 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(define-const var3127 (Array Int ClassObject) var423) ; Statement: r50 = $r49 
(define-const var2156 Int (getLength-Arr-ClassObject-1 var423)) ; Statement: $i1 = lengthof $r49 
(define-const var1482 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(assert (>= var1482 var2156)) ; Cond: i2 >= $i1 
(assert true)
;(assert (append/672562846 var3936!6 ") ")) ; Statement: virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ") 
(declare-const var3936!7 String)
(assert (= var3936!7 (str.++ var3936!6 ") ")))
(assert true)
(define-const var3182 var2294 (get/-1007821573 var552 "arguments")) ; Statement: $r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
 ; Statement: if $r37 == null goto $r51 = null 
(assert (not (= var3182 null-var2294))) ; Negate: Cond: $r37 == null  
(assert true)
(define-const var970 var2294 (get/-1007821573 var552 "arguments")) ; Statement: $r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments") 
(define-const var3745 (Array Int var2294) (cast-from-var2294-to-__Array__Int__var2294__ var970)) ; Statement: $r51 = (java.lang.Object[]) $r39 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (= var3745 null-__Array__Int__var2294__)) ; Cond: $r51 == null 
(assert true)
(define-const var849 String (toString/-2075883882 var3936!7)) ; Statement: $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r52 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getInvocationTime/675231966=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), toInstant/-822818885=([java.util.Date], java.time.Instant), var3125_systemDefault/1019915793=([], java.time.ZoneId), var3585_ofInstant/129408697=([java.time.Instant, java.time.ZoneId], java.time.LocalDateTime), format/372879155=([java.time.LocalDateTime, java.time.format.DateTimeFormatter], java.lang.String), getOutTime/324948452=([org.apache.dubbo.rpc.support.AccessLogData], java.util.Date), get/-1007821573=([org.apache.dubbo.rpc.support.AccessLogData, java.lang.String], java.lang.Object), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-522406933=([java.lang.Object], java.lang.String), var237_isNotEmpty/-1251449450=([java.lang.String], boolean), cast-from-var2294-to-__Array__Int__ClassObject__=([java.lang.Object], java.lang.Class[]), getLength-Arr-ClassObject-1=([java.lang.Class[]], int), cast-from-var2294-to-__Array__Int__var2294__=([java.lang.Object], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var310=org.apache.dubbo.rpc.support.AccessLogData, var552=r1, var3936=$r0, var1067=$r8, var1069=java.util.Date, var3519=$r2, var941=java.time.Instant, var709=$r4, var3125=java.time.ZoneId, var325=$r3, var3585=java.time.LocalDateTime, var2126=$r6, var713=java.time.format.DateTimeFormatter, var445=$r5, var2935=$r7, var2005=$r9, var2506=$r10, var3575=$r11, var2190=$r18, var2198=$r12, var898=$r14, var3484=$r13, var2983=$r16, var263=$r15, var1089=$r17, var8=$r19, var3387=$r21, var2294=java.lang.Object, var1079=$r20, var2593=$r22, var1572=$r24, var3571=$r23, var110=$r25, var3104=$r27, var3541=$r26, var1494=$r28, var658=$r30, var123=$r29, var1008=$r31, var279=$r32, var1792=$r46, var3526=$r47, var237=org.apache.dubbo.common.utils.StringUtils, var2085=$z0, var3497=$r33, var882=$r34, var536=$r44, var2489=$r48, var528=$z1, var2036=$r35, var2116=$r36, var3666=$r42, var423=$r49, var3224=z2, var3127=r50, var2156=$i1, var1482=i2, var3182=$r37, var970=$r39, var3745=$r51, var849=$r52}
; {org.apache.dubbo.rpc.support.AccessLogData=var310, r1=var552, $r0=var3936, $r8=var1067, java.util.Date=var1069, $r2=var3519, java.time.Instant=var941, $r4=var709, java.time.ZoneId=var3125, $r3=var325, java.time.LocalDateTime=var3585, $r6=var2126, java.time.format.DateTimeFormatter=var713, $r5=var445, $r7=var2935, $r9=var2005, $r10=var2506, $r11=var3575, $r18=var2190, $r12=var2198, $r14=var898, $r13=var3484, $r16=var2983, $r15=var263, $r17=var1089, $r19=var8, $r21=var3387, java.lang.Object=var2294, $r20=var1079, $r22=var2593, $r24=var1572, $r23=var3571, $r25=var110, $r27=var3104, $r26=var3541, $r28=var1494, $r30=var658, $r29=var123, $r31=var1008, $r32=var279, $r46=var1792, $r47=var3526, org.apache.dubbo.common.utils.StringUtils=var237, $z0=var2085, $r33=var3497, $r34=var882, $r44=var536, $r48=var2489, $z1=var528, $r35=var2036, $r36=var2116, $r42=var3666, $r49=var423, z2=var3224, r50=var3127, $i1=var2156, i2=var1482, $r37=var3182, $r39=var970, $r51=var3745, $r52=var849}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.Object: java.lang.String toString()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 10,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 6,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 4,"<org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.support.AccessLogData;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r8 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r2 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getInvocationTime()>();	$r4 = virtualinvoke $r2.<java.util.Date: java.time.Instant toInstant()>();	$r3 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r6 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r4, $r3);	$r5 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r7 = virtualinvoke $r6.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r5);	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r7);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("-> ");	$r18 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("[");	$r12 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.util.Date getOutTime()>();	$r14 = virtualinvoke $r12.<java.util.Date: java.time.Instant toInstant()>();	$r13 = staticinvoke <java.time.ZoneId: java.time.ZoneId systemDefault()>();	$r16 = staticinvoke <java.time.LocalDateTime: java.time.LocalDateTime ofInstant(java.time.Instant,java.time.ZoneId)>($r14, $r13);	$r15 = <org.apache.dubbo.rpc.support.AccessLogData: java.time.format.DateTimeFormatter MESSAGE_DATE_FORMATTER>;	$r17 = virtualinvoke $r16.<java.time.LocalDateTime: java.lang.String format(java.time.format.DateTimeFormatter)>($r15);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r17);	$r21 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("] ");	$r20 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-host");	$r22 = virtualinvoke $r21.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r20);	$r24 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r23 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("remote-port");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r23);	$r27 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" -> ");	$r26 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("localhost");	$r28 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r26);	$r30 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(58);	$r29 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("local-port");	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r29);	virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" - ");	$r32 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	if $r32 == null goto $r47 = "";	$r46 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("group");	$r47 = virtualinvoke $r46.<java.lang.Object: java.lang.String toString()>();	goto [?= $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47)];	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r47);	if $z0 == 0 goto $r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	$r33 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("service");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r33);	$r34 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	if $r34 == null goto $r48 = "";	$r44 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("version");	$r48 = virtualinvoke $r44.<java.lang.Object: java.lang.String toString()>();	goto [?= $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48)];	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNotEmpty(java.lang.String)>($r48);	if $z1 == 0 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(32);	$r35 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("method-name");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r35);	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(40);	$r36 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	if $r36 == null goto $r49 = newarray (java.lang.Class)[0];	$r42 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("types");	$r49 = (java.lang.Class[]) $r42;	goto [?= z2 = 1];	z2 = 1;	r50 = $r49;	$i1 = lengthof $r49;	i2 = 0;	if i2 >= $i1 goto virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(") ");	$r37 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	if $r37 == null goto $r51 = null;	$r39 = specialinvoke r1.<org.apache.dubbo.rpc.support.AccessLogData: java.lang.Object get(java.lang.String)>("arguments");	$r51 = (java.lang.Object[]) $r39;	goto [?= (branch)];	if $r51 == null goto $r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r52 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r52
;block_num 14